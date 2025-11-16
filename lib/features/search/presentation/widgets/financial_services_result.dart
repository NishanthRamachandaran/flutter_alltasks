// // financial_services_result.dart
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class FinancialServicesResults extends StatelessWidget {
//   final List<String> searchResults;
//   final TextEditingController searchController;

//   const FinancialServicesResults({
//     super.key,
//     required this.searchResults,
//     required this.searchController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
    
//     if (searchController.text.isEmpty) {
//       return _buildEmptyState(context);
//     }

//     if (searchResults.isEmpty) {
//       return _buildNoResults(context);
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Financial Services Results",
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         SizedBox(height: screenHeight * 0.02),
//         Expanded(
//           child: ListView.builder(
//             itemCount: searchResults.length,
//             itemBuilder: (context, index) {
//               return _buildSearchResultItem(context, searchResults[index]);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchResultItem(BuildContext context, String service) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final searchQuery = searchController.text.toLowerCase();
    
//     return Container(
//       margin: EdgeInsets.only(bottom: screenHeight * 0.015),
//       padding: EdgeInsets.all(screenWidth * 0.04),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: searchQuery.isEmpty
//                 ? _buildNormalText(service)
//                 : _buildHighlightedText(service, searchQuery),
//           ),
//           Icon(
//             Icons.north_east,
//             size: 20,
//             color: Colors.blue.shade900,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNormalText(String text) {
//     return Text(
//       text,
//       style: GoogleFonts.poppins(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: Colors.blue,
//       ),
//     );
//   }

//   Widget _buildHighlightedText(String text, String query) {
//     final textSpans = <TextSpan>[];
//     final pattern = RegExp(query, caseSensitive: false);
//     final matches = pattern.allMatches(text);
//     int currentIndex = 0;
    
//     for (final match in matches) {
//       if (match.start > currentIndex) {
//         textSpans.add(TextSpan(
//           text: text.substring(currentIndex, match.start),
//           style: GoogleFonts.poppins(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.blue,
//           ),
//         ));
//       }
      
//       textSpans.add(TextSpan(
//         text: text.substring(match.start, match.end),
//         style: GoogleFonts.poppins(
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//           color: Colors.blue.shade900,
//         ),
//       ));
      
//       currentIndex = match.end;
//     }
    
//     if (currentIndex < text.length) {
//       textSpans.add(TextSpan(
//         text: text.substring(currentIndex),
//         style: GoogleFonts.poppins(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           color: Colors.blue,
//         ),
//       ));
//     }
    
//     return RichText(text: TextSpan(children: textSpans));
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
    
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.search,
//             size: screenWidth * 0.2,
//             color: Colors.grey.shade300,
//           ),
//           SizedBox(height: screenHeight * 0.03),
//           Text(
//             "Search for financial services",
//             style: GoogleFonts.poppins(
//               fontSize: 16,
//               color: Colors.grey.shade600,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.01),
//           Text(
//             "Try 'Finance', 'Loan', 'Investment'",
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               color: Colors.grey.shade500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNoResults(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
    
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.search_off,
//             size: screenWidth * 0.15,
//             color: Colors.grey.shade400,
//           ),
//           SizedBox(height: screenHeight * 0.02),
//           Text(
//             "No financial services found for '${searchController.text}'",
//             style: GoogleFonts.poppins(
//               fontSize: 16,
//               color: Colors.grey.shade600,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.01),
//           Text(
//             "Try different financial keywords",
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               color: Colors.grey.shade500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }