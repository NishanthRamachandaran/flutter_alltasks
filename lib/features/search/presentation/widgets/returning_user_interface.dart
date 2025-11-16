// // returning_user_interface.dart
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'search_option_item.dart';
// import 'suggestion_card_item.dart';

// class ReturningUserInterface extends StatelessWidget {
//   final TextEditingController searchController;

//   const ReturningUserInterface({
//     super.key,
//     required this.searchController,
//   });

//   void _onSearchChanged(String query) {
//     searchController.text = query;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
    
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Search for",
//             style: GoogleFonts.poppins(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.02),

//           Column(
//             children: [
//               "Home Finance", "Instant Finance", "Advance Salary", 
//             ].map((option) {
//               return SearchOptionItem(
//                 option: option,
//                 onTap: () => _onSearchChanged(option),
//               );
//             }).toList(),
//           ),
//           SizedBox(height: screenHeight * 0.03),

//           Text(
//             "Suggestions",
//             style: GoogleFonts.poppins(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.02),

//           Row(
//             children: [
//               Expanded(
//                 child: SuggestionCardItem(
//                   title: "Mobile Recharge",
//                   onTap: () => _onSearchChanged("Mobile Recharge"),
//                 ),
//               ),
//               SizedBox(width: screenWidth * 0.03),
//               Expanded(
//                 child: SuggestionCardItem(
//                   title: "Offers",
//                   onTap: () => _onSearchChanged("Offers"),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }