// // returning_user_access.dart
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../../core/constants/app_colors/default_colors.dart';

// class ReturningUserAccess extends StatelessWidget {
//   final VoidCallback onTap;

//   const ReturningUserAccess({
//     super.key,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
    
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: DefaultColors.blue9D.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: DefaultColors.blue9D,
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: DefaultColors.blue9D,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.business_center,
//                 size: screenWidth * 0.05,
//                 color: DefaultColors.white,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Financial Services",
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: DefaultColors.blue9D,
//                     ),
//                   ),
//                   Text(
//                     "Tap here for returning user access",
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: DefaultColors.blue9D.withOpacity(0.8),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               size: screenWidth * 0.04,
//               color: DefaultColors.blue9D,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }