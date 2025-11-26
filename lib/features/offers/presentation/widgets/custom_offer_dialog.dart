import 'dart:ui';
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
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(child: _buildContent(context)),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: _style(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _title(),
            const SizedBox(height: 16),
            _body(context),
            const SizedBox(height: 20),
            if (widget.showDontShowAgain) ..._dontShowAgainSection(),
            _primaryButton(),
            const SizedBox(height: 12),
            _secondaryButton(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _style() => BoxDecoration(
        color: DefaultColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 25,
              offset: const Offset(0, 8))
        ],
      );

  Widget _title() => Text(
        widget.title,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: DefaultColors.blue9D,
        ),
      );

  Widget _body(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(
          width: w * 0.26,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(widget.imagePath, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: _desc()),
      ],
    );
  }

  Widget _desc() => RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(
              fontSize: 14, color: DefaultColors.black, height: 1.5),
          children: _formatDesc(),
        ),
      );

  List<TextSpan> _formatDesc() => widget.description.split(" ").map((word) {
        final bold = word.contains(RegExp(r'\d')) ||
            word.toLowerCase().contains("maximum") ||
            word.toLowerCase().contains("limit") ||
            word.toLowerCase().contains("upto");
        return TextSpan(
          text: "$word ",
          style: TextStyle(
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400),
        );
      }).toList();

  List<Widget> _dontShowAgainSection() => [
        Row(
          children: [
            Checkbox(
              value: _dontShowAgain,
              onChanged: (v) {
                setState(() => _dontShowAgain = v!);
                ref.read(offerVisibilityProvider.notifier).state = {
                  ...ref.read(offerVisibilityProvider),
                  widget.offerId: v!,
                };
              },
              activeColor: DefaultColors.blue9D,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text("Don't show this offer again!",
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: DefaultColors.gray71)),
            ),
          ],
        ),
        const SizedBox(height: 18),
      ];

  Widget _primaryButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: widget.onPrimaryButtonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: DefaultColors.blue9D,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(widget.primaryButtonText,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      );

  Widget _secondaryButton() => SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: widget.onSecondaryButtonPressed,
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            side: BorderSide(color: DefaultColors.blue9D),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(widget.secondaryButtonText,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: DefaultColors.blue9D)),
        ),
      );
}
