import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors/default_colors.dart';
import '../controller/search_provider.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_content_manager.dart';
// import '../widgets/returning_user_screen.dart';

@RoutePage()
class UnifiedSearchScreen extends ConsumerStatefulWidget {
  const UnifiedSearchScreen({super.key});

  @override
  ConsumerState<UnifiedSearchScreen> createState() => _UnifiedSearchScreenState();
}

class _UnifiedSearchScreenState extends ConsumerState<UnifiedSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onClearSearch() {
    _searchController.clear();
    ref.read(searchQueryProvider.notifier).state = '';
  }

  void _onCancelSearch() {
    Navigator.of(context).pop();
  }

  //  - Returning user navigation
  // void _navigateToReturningUser() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => const ReturningUserScreen(),
  //     ),
  //   );
  // }

  bool get _isSearching => _searchController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      backgroundColor: DefaultColors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 36, left: 20, right: 8, bottom: 8),
        child: Column(
          children: [
            SearchBarWidget(
              controller: _searchController,
              onCancel: _onCancelSearch,
              onClear: _onClearSearch,
              screenWidth: screenWidth,
            ),
            SizedBox(height: screenWidth * 0.04),
            
            Expanded(
              child: SearchContentManager(
                isSearching: _isSearching,
                screenWidth: screenWidth,
                searchController: _searchController,
                searchResults: searchResults,
                // onReturningUserTap: _navigateToReturningUser, // - Returning user feature
              ),
            ),
          ],
        ),
      ),
    );
  }
}