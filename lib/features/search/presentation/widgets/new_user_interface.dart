// new_user_interface.dart - Add the access widget
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors/default_colors.dart';
import 'feature_container.dart';
import 'search_chip_item.dart';
import 'search_chip_row.dart';
// import 'returning_user_access.dart'; //  - Returning user feature

class NewUserInterface extends ConsumerWidget {
  final TextEditingController searchController;
  // final VoidCallback onReturningUserTap; // - Returning user feature

  const NewUserInterface({
    super.key,
    required this.searchController,
    // required this.onReturningUserTap, //  - Returning user feature
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  - Returning user access widget
          // ReturningUserAccess(onTap: onReturningUserTap),
          // const SizedBox(height: 16),

          Text(
            "Search for ",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: DefaultColors.black,
            ),
          ),
          const SizedBox(height: 12),

         
          SearchChipRow(
            titles: ["Mobile Recharge", "Track Billers"],
            icons: [Icons.phone_android, Icons.receipt_long],
          ),
          const SizedBox(height: 12),

          SearchChipRow(
            titles: ["Credit Card Bills", "Offers"],
            icons: [Icons.credit_card, Icons.local_offer],
          ),
          const SizedBox(height: 12),

          SearchChipItem(
            title: "Your Cheque Book",
            icon: Icons.book,
          ),
          const SizedBox(height: 16),

          Text(
            "What's new?",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: DefaultColors.black,
            ),
          ),
          const SizedBox(height: 16),

          const FeatureContainer(),
        ],
      ),
    );
  }
}