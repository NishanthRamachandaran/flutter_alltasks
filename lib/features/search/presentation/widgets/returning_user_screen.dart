// // returning_user_screen.dart
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../../core/constants/app_colors/default_colors.dart';
// import '../controller/search_provider.dart';
// import '../widgets/search_bar.dart';
// import 'financial_services_result.dart';
// import 'returning_user_interface.dart';

// @RoutePage()
// class ReturningUserScreen extends ConsumerStatefulWidget {
//   const ReturningUserScreen({super.key});

//   @override
//   ConsumerState<ReturningUserScreen> createState() => _ReturningUserScreenState();
// }

// class _ReturningUserScreenState extends ConsumerState<ReturningUserScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     _searchFocusNode.requestFocus();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     super.dispose();
//   }

//   void _onClearSearch() {
//     _searchController.clear();
//     ref.read(searchQueryProvider.notifier).state = '';
//   }

//   void _onCancelSearch() {
//     Navigator.of(context).pop();
//   }

//   bool get _isSearching => _searchController.text.isNotEmpty;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final financialResults = ref.watch(financialServicesResultsProvider);

//     return Scaffold(
//       backgroundColor: DefaultColors.white,
//       appBar: AppBar(
//         backgroundColor: DefaultColors.white,
//         title: Text(
//           "Financial Services",
//           style: TextStyle(
//             color: DefaultColors.blue9D,
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
//         ),
//         elevation: 0,
//         automaticallyImplyLeading: false, 
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             SearchBarWidget(
//               controller: _searchController,
//               onCancel: _onCancelSearch,
//               onClear: _onClearSearch,
//               screenWidth: screenWidth,
//             ),
//             SizedBox(height: screenHeight * 0.02),
            
//             Expanded(
//               child: _isSearching
//                   ? FinancialServicesResults(
//                       searchResults: financialResults.value ?? [],
//                       searchController: _searchController,
//                     )
//                   : ReturningUserInterface(
//                       searchController: _searchController,
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }