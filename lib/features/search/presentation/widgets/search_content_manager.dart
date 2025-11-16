import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/widgets/common_error_widget.dart';
import '../../../../core/constants/widgets/common_loading_widget.dart';
import '../controller/search_provider.dart';
import 'new_user_interface.dart';
import 'new_user_search_results.dart';

class SearchContentManager extends ConsumerWidget {
  final bool isSearching;
  final double screenWidth;
  final TextEditingController searchController;
  final AsyncValue<List<String>> searchResults;
  // final VoidCallback onReturningUserTap; //  - Returning user feature

  const SearchContentManager({
    super.key,
    required this.isSearching,
    required this.screenWidth,
    required this.searchController,
    required this.searchResults,
    // required this.onReturningUserTap, // - Returning user feature
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isSearching) {
      return searchResults.when(
        loading: () => CommonLoadingWidget(
          width: double.infinity,
          height: 200,
        ),
        error: (error, stack) => CommonErrorWidget(
          message: 'Failed to load results',
          onRetry: () => ref.refresh(searchResultsProvider),
          iconSize: screenWidth * 0.15,
          fontSize: screenWidth * 0.04,
        ),
        data: (results) => NewUserSearchResults(
          searchResults: results,
          searchController: searchController,
          screenWidth: screenWidth,
        ),
      );
    } else {
      return NewUserInterface(
        searchController: searchController,
        // onReturningUserTap: onReturningUserTap, //  - Returning user feature
      );
    }
  }
}