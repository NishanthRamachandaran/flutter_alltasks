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

class _CustomOfferDialogState extends ConsumerState<CustomOfferDialog> {
  bool _dontShowAgain = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Dialog(
      backgroundColor: DefaultColors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      width: double.infinity,
      decoration: _buildDialogDecoration(),
      child:  Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(context),
            SizedBox(height: 16),
            _buildContentRow(context),
            SizedBox(height: 20),
            if (widget.showDontShowAgain) ..._buildDontShowAgainSection(context),
            _buildPrimaryButton(context),
            SizedBox(height: 12),
            _buildSecondaryButton(context),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDialogDecoration() {
    return BoxDecoration(
      color: DefaultColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: DefaultColors.black.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: DefaultColors.blue9D,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ),
    );
  }

  Widget _buildContentRow(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageStack(context),
        SizedBox(width: screenWidth * 0.04),
        _buildDescription(context),
      ],
    );
  }

  Widget _buildImageStack(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return SizedBox(
      width: screenWidth * 0.25,
      height: screenHeight * 0.1125,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0,
            top: screenHeight * 0.03125,
            child: Transform.rotate(
              angle: -0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.imagePath,
                  width: screenWidth * 0.225,
                  height: screenHeight * 0.06875,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          
          Positioned(
            left: screenWidth * 0.0125,
            top: screenHeight * 0.05,
            child: Transform.rotate(
              angle: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/visa.png',
                  width: screenWidth * 0.225,
                  height: screenHeight * 0.0625,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: DefaultColors.black,
              height: 1.5,
            ),
            children: _parseDescription(),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _parseDescription() {
    final words = widget.description.split(' ');
    List<TextSpan> spans = [];

    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      bool isBold = word.contains(RegExp(r'\d')) ||
          word.toLowerCase().contains('maximum') ||
          word.toLowerCase().contains('limit') ||
          word.toLowerCase().contains('upto');

      spans.add(
        TextSpan(
          text: word + (i < words.length - 1 ? ' ' : ''),
          style: GoogleFonts.poppins(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            color: DefaultColors.black,
          ),
        ),
      );
    }
    return spans;
  }

  List<Widget> _buildDontShowAgainSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth * 0.05,
            height: screenWidth * 0.05,
            child: Checkbox(
              value: _dontShowAgain,
              onChanged: (value) {
                setState(() {
                  _dontShowAgain = value ?? false;
                });
                if (_dontShowAgain) {
                  ref.read(offerVisibilityProvider.notifier).state = {
                    ...ref.read(offerVisibilityProvider),
                    widget.offerId: true,
                  };
                } else {
                  ref.read(offerVisibilityProvider.notifier).state = {
                    ...ref.read(offerVisibilityProvider),
                    widget.offerId: false,
                  };
                }
              },
              activeColor: DefaultColors.blue9D,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Flexible(
            child: Text(
              "Don't Show this offer again!",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: DefaultColors.gray71,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
    ];
  }

  Widget _buildPrimaryButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPrimaryButtonPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: DefaultColors.blue9D,
          foregroundColor: DefaultColors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.primaryButtonText,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Icon(Icons.north_east, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: widget.onSecondaryButtonPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: BorderSide(color: DefaultColors.blue9D, width: 1.5),
        ),
        child: Text(
          widget.secondaryButtonText,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: DefaultColors.blue9D,
          ),
        ),
      ),
    );
  }
}