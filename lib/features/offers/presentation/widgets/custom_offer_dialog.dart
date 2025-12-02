import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors/default_colors.dart';
import '../conroller/offer_provider.dart';

class CustomOfferDialog extends ConsumerStatefulWidget {
  final String offerId;
  final String title;
  final String imagePath;
  final String description;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryButtonPressed;
  final VoidCallback onSecondaryButtonPressed;
  final bool showDontShowAgain;

  const CustomOfferDialog({
    super.key,
    required this.offerId,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryButtonPressed,
    required this.onSecondaryButtonPressed,
    this.showDontShowAgain = true,
  });

  @override
  ConsumerState<CustomOfferDialog> createState() => _CustomOfferDialogState();
}

class _CustomOfferDialogState extends ConsumerState<CustomOfferDialog>
    with SingleTickerProviderStateMixin {
  bool _dontShowAgain = false;
  bool _isCollapsing = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _moveAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnim = Tween(
      begin: 1.0,
      end: 0.03,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnim = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _moveAnim = Tween(
      begin: Offset.zero,
      end: const Offset(0, 1.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: w * 0.045),
      child: ClipRect(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return SlideTransition(
                  position: _moveAnim,
                  child: ScaleTransition(
                    scale: _scaleAnim,
                    child: FadeTransition(
                      opacity: _fadeAnim,
                      child: _mainCard(context, w, h),
                    ),
                  ),
                );
              },
            ),
            _buildCloseButton(context, w, h),
          ],
        ),
      ),
    );
  }

  Widget _mainCard(BuildContext context, double w, double h) {
    return Container(
      decoration: BoxDecoration(
        color: DefaultColors.white,
        borderRadius: BorderRadius.circular(w * 0.07),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: w * 0.05,
            offset: Offset(0, h * 0.01),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(w * 0.035, h * 0.015, w * 0.035, h * 0.03),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBlueContent(context, w, h),
            SizedBox(height: h * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildBlueContent(BuildContext context, double w, double h) {
    return Container(
      decoration: BoxDecoration(
        color: DefaultColors.skyBlue,
        borderRadius: BorderRadius.circular(w * 0.05),
      ),
      child: Column(
        children: [
          _buildImageStack(context),
          SizedBox(height: h * 0.03),
          Padding(
            padding: EdgeInsets.fromLTRB(
              w * 0.06,
              h * 0.02,
              w * 0.06,
              h * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(context, w),
                SizedBox(height: h * 0.015),
                _buildDescription(context),
                SizedBox(height: h * 0.02),
                if (widget.showDontShowAgain)
                  _buildDontShowAgainSection(context),
                SizedBox(height: h * 0.02),
                _buildPrimaryButton(context, w, h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageStack(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final cardW = w * 0.34;
    final cardH = w * 0.21;
    final visibleHeight = cardH * 0.78;

    return ClipRect(
      child: SizedBox(
        width: cardW + w * 0.03,
        height: visibleHeight,
        child: Stack(
          children: [
            Positioned(
              top: -(cardH * 0.22),
              right: 0,
              child: _img("assets/images/credit.png", cardW, cardH),
            ),
            Positioned(
              top: -(cardH * 0.18),
              left: 0,
              child: _img(widget.imagePath, cardW, cardH),
            ),
          ],
        ),
      ),
    );
  }

  Widget _img(String p, double w, double h) => ClipRRect(
    borderRadius: BorderRadius.circular(w * 0.08),
    child: Image.asset(p, width: w, height: h, fit: BoxFit.cover),
  );

  Widget _buildTitle(BuildContext context, double w) => Text(
    widget.title,
    style: GoogleFonts.poppins(
      fontSize: w * 0.046,
      fontWeight: FontWeight.w700,
      color: DefaultColors.blue9D,
    ),
  );

  /// ⭐ Number bolding is restored here
  Widget _buildDescription(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(
          fontSize: 15,
          height: 1.4,
          color: Colors.black87,
        ),
        children: _parseDescription(),
      ),
    );
  }

  List<TextSpan> _parseDescription() {
    final words = widget.description.split(' ');
    List<TextSpan> spans = [];
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      bool isBold =
          RegExp(r'[\d,.]').hasMatch(word) ||
          word.toLowerCase().contains('maximum') ||
          word.toLowerCase().contains('limit') ||
          word.toLowerCase().contains('upto') ||
          word.toUpperCase() == 'QAR';
      spans.add(
        TextSpan(
          text: "$word ",
          style: GoogleFonts.poppins(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            color: Colors.black87,
          ),
        ),
      );
    }
    return spans;
  }

  Widget _buildDontShowAgainSection(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        setState(() => _dontShowAgain = !_dontShowAgain);
        ref.read(offerVisibilityProvider.notifier).state = {
          ...ref.read(offerVisibilityProvider),
          widget.offerId: !_dontShowAgain,
        };
      },
      child: Row(
        children: [
          Checkbox(
            value: _dontShowAgain,
            onChanged: (val) {
              setState(() => _dontShowAgain = val ?? false);
              ref.read(offerVisibilityProvider.notifier).state = {
                ...ref.read(offerVisibilityProvider),
                widget.offerId: val ?? false,
              };
            },
            activeColor: DefaultColors.blue9D,
          ),
          Expanded(
            child: Text(
              "Don't Show this offer again!",
              style: GoogleFonts.poppins(
                fontSize: w * 0.028,
                color: DefaultColors.gray82,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context, double w, double h) =>
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: widget.onPrimaryButtonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: DefaultColors.blue9D,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(w * 0.1),
            ),
            padding: EdgeInsets.symmetric(vertical: h * 0.014),
          ),
          child: Text(
            widget.primaryButtonText,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: w * 0.034,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

  Widget _buildCloseButton(BuildContext context, double w, double h) =>
      GestureDetector(
        onTap: () {
          if (_isCollapsing) return;
          setState(() => _isCollapsing = true);
          _controller.forward();

          Future.delayed(const Duration(milliseconds: 900), () {
            if (mounted) Navigator.pop(context);
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.07,
            vertical: h * 0.011,
          ),
          decoration: BoxDecoration(
            color: DefaultColors.blueFA,
            borderRadius: BorderRadius.circular(w * 0.1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.secondaryButtonText,
                style: GoogleFonts.poppins(
                  fontSize: w * 0.034,
                  fontWeight: FontWeight.w600,
                  color: DefaultColors.black,
                ),
              ),
              SizedBox(width: w * 0.015),
              Icon(Icons.close, size: w * 0.045, color: DefaultColors.black),
            ],
          ),
        ),
      );
}
