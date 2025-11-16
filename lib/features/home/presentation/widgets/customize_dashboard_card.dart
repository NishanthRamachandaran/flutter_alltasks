import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors/default_colors.dart';

class CustomizeDashboardCard extends StatelessWidget {
  const CustomizeDashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
   // final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DefaultColors.dashboardGray,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: DefaultColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.dashboard_customize_outlined,
              color: DefaultColors.blueLightBase,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Customise your dashboard",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: DefaultColors.blueLightBase,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Explore more banking features",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: DefaultColors.blueLightBase.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}