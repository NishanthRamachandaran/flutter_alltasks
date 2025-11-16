import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors/default_colors.dart';

class OfferItem extends StatelessWidget {
  final Map<String, dynamic> offerData;
  final VoidCallback? onTap;

  const OfferItem({super.key, required this.offerData, this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: screenWidth * 0.18,           
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: screenHeight * 0.075,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  _buildCircle(context),
                  _buildDiscountBadge(context),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.008),

            _buildOfferTitle(context, screenWidth),
          ],
        ),
      ),
    );
  }

  
  Widget _buildCircle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.14,
      height: screenWidth * 0.14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: DefaultColors.blueLightBase,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          offerData['iconAsset'] as String,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // -------------------- DISCOUNT BADGE -------------------- //
  Widget _buildDiscountBadge(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      bottom: -screenHeight * 0.008,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFFCB2CF2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          offerData['discountText'] as String,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  // -------------------- TITLE (2 lines always) -------------------- //
  Widget _buildOfferTitle(BuildContext context, double screenWidth) {
  final title = offerData['title'] as String;

  // force line-break for Invest in Gold
  final fixedTitle = title == "Invest in Gold"
      ? "Invest in\nGold"
      : title;

  return SizedBox(
    width: screenWidth * 0.22,
    child: Text(
      fixedTitle,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: DefaultColors.black,
            height: 1.25,
          ),
      maxLines: 2,
      overflow: TextOverflow.visible,
      softWrap: true,
    ),
  );
}
}