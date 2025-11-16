// lib/features/search/presentation/controllers/search_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/static_search_data.dart';

// Search Query State
final searchQueryProvider = StateProvider<String>((ref) => '');

// Search Results Provider for New User
final searchResultsProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  return await StaticSearchData.getSearchSuggestions(query);
});

// Financial Services Results Provider for Returning User
// final financialServicesResultsProvider = FutureProvider.autoDispose<List<String>>((ref) async {
//   final query = ref.watch(searchQueryProvider);
//   return await StaticSearchData.getFinancialServices(query);
// });

// Whats New Features Provider
final whatsNewFeaturesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  return await StaticSearchData.getWhatsNewFeatures();
});