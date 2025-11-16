import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors/default_colors.dart';

class ReferEarnContent extends StatelessWidget {
  const ReferEarnContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Stack(
      clipBehavior: Clip.none, 
      children: [
        _buildContentCard(context, screenWidth, screenHeight),
        _buildGiftImage(screenWidth, screenHeight),
      ],
    );
  }

  Widget _buildContentCard(BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DefaultColors.dashboardLightBlue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth * 0.6,
            child: _buildDescription(),
          ),
          const SizedBox(height: 12),
          _buildReferralCodeSection(),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return const SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Help your friends grow\ntheir wealth",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.4,
              color: DefaultColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralCodeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildReferralCode(),
      ],
    );
  }

  Widget _buildReferralCode() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Text(
            "A successful referral earns you 50 points.",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.2,
              color: DefaultColors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGiftImage(double screenWidth, double screenHeight) {
    return Positioned(
      top: -screenHeight * 0.07,     // moved slightly down
      right: -screenWidth * 0.09,    // slight right
      child: Image.asset(
        'assets/images/gift.png',
        width: screenWidth * 0.55,
        height: screenHeight * 0.18,
        fit: BoxFit.contain,
      ),
    );
  }
}
