import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors/default_colors.dart';
class WealthAdvisorySection extends StatelessWidget {
  const WealthAdvisorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Wealth Advisory",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: DefaultColors.black,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    "Learn More",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: DefaultColors.blueLightBase,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.north_east,
                    size: 20,
                    color: DefaultColors.blueLightBase,
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: screenHeight * 0.02),

        Row(
          children: [
            _buildAdvisoryCard(context,
              icon: Icons.work_outline,
              title: "Portfolio\nManagement",
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            const SizedBox(width: 16),
            _buildAdvisoryCard(context,
              icon: Icons.savings_outlined,
              title: "Mutual\nFunds",
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
          ],
        ),
      ],
    );
  }

 Widget _buildAdvisoryCard(
  BuildContext context, {
  required IconData icon,
  required String title,
  required double screenWidth,
  required double screenHeight,
}) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: DefaultColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- TOP ICON BOX --------
          Container(
            height: screenHeight * 0.08,
            decoration: BoxDecoration(
              color: DefaultColors.grayF4,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  icon,           // <-- FIXED: now dynamic
                  color: DefaultColors.blueLightBase,
                  size: 32,
                ),
              ),
            ),
          ),

          // -------- BOTTOM TITLE + ARROW --------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,        // <-- FIXED: now dynamic
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: DefaultColors.black,
                    ),
                  ),
                ),
                const Icon(
                  Icons.north_east,
                  color: DefaultColors.black,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}