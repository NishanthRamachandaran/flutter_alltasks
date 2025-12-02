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
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnim = Tween<double>(
      begin: 1,
      end: 0.03,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnim = Tween<double>(
      begin: 1,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _moveAnim = Tween<Offset>(
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
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: DefaultColors.transparent,
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
      width: double.infinity,
      decoration: BoxDecoration(
        color: DefaultColors.white,
        borderRadius: BorderRadius.circular(w * 0.07),
        boxShadow: [
          BoxShadow(
            color: DefaultColors.black.withOpacity(0.10),
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
            SizedBox(height: h * 0.015),
            SizedBox(height: h * 0.03),
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
          _buildImageStack(context, w, h),
          SizedBox(height: h * 0.04),
          Padding(
            padding: EdgeInsets.fromLTRB(
              w * 0.06,
              h * 0.02,
              w * 0.06,
              h * 0.02,
            ),
            child: Column(
              children: [
                _buildTitle(context, w),
                SizedBox(height: h * 0.02),
                _buildDescription(context, w),
                SizedBox(height: h * 0.02),
                if (widget.showDontShowAgain)
                  _buildDontShowAgainSection(context),
                SizedBox(height: h * 0.015),
                _buildPrimaryButton(context, w, h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageStack(BuildContext context, double w, double h) {
    final cardW = w * 0.35;
    final cardH = w * 0.22;
    final hide = cardH * 0.20;

    return ClipRect(
      child: SizedBox(
        width: cardW + w * 0.04,
        height: cardH - hide + h * 0.01,
        child: Stack(
          children: [
            Positioned(
              top: -hide,
              right: 0,
              child: _img("assets/images/credit.png", cardW, cardH),
            ),
            Positioned(
              top: -hide + h * 0.01,
              left: 0,
              child: _img(widget.imagePath, cardW, cardH),
            ),
          ],
        ),
      ),
    );
  }

  Widget _img(String p, double w, double h) => ClipRRect(
    borderRadius: BorderRadius.circular(w * 0.07),
    child: Image.asset(p, width: w, height: h, fit: BoxFit.cover),
  );

  Widget _buildTitle(BuildContext context, double w) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      widget.title,
      style: GoogleFonts.poppins(
        fontSize: w * 0.04,
        fontWeight: FontWeight.w700,
        color: DefaultColors.blue9D,
      ),
    ),
  );

  Widget _buildDescription(BuildContext context, double w) => RichText(
    text: TextSpan(
      style: GoogleFonts.poppins(
        fontSize: w * 0.038,
        height: 1.4,
        color: DefaultColors.black,
      ),
      children: _parseDescription(w),
    ),
  );

  List<TextSpan> _parseDescription(double w) =>
      widget.description.split(' ').map((word) {
        final bold = RegExp(r'[\d,.]').hasMatch(word);
        return TextSpan(
          text: "$word ",
          style: GoogleFonts.poppins(
            fontSize: w * 0.038,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            color: DefaultColors.black,
          ),
        );
      }).toList();

Widget _buildDontShowAgainSection(BuildContext context) {
  final w = MediaQuery.of(context).size.width;
  final h = MediaQuery.of(context).size.height;

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
        SizedBox(
          width: w * 0.06,
          height: w * 0.06,
          child: Checkbox(
            value: _dontShowAgain,
            onChanged: (val) {
              setState(() => _dontShowAgain = val ?? false);
              ref.read(offerVisibilityProvider.notifier).state = {
                ...ref.read(offerVisibilityProvider),
                widget.offerId: val ?? false,
              };
            },
            activeColor: DefaultColors.blue9D,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
          ),
        ),
        SizedBox(width: w * 0.02),
        Expanded(
          child: Text(
            "Don't Show this offer again!",
            style: GoogleFonts.poppins(
              fontSize: w * 0.028,
              color: DefaultColors.gray82,
              height: 1.0,
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
            padding: EdgeInsets.symmetric(vertical: h * 0.015),
          ),
          child: Text(
            widget.primaryButtonText,
            style: GoogleFonts.poppins(
              color: DefaultColors.white,
              fontSize: w * 0.036,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

  Widget _buildCloseButton(BuildContext context, double w, double h) {
    return GestureDetector(
      onTap: () {
        if (_isCollapsing) return;
        setState(() => _isCollapsing = true);
        _controller.forward();

        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) Navigator.pop(context);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.07,
          vertical: h * 0.012,
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
                fontSize: w * 0.036,
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
}
