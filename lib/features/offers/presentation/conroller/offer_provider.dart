import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Simple offer data as strings - NO MODELS
final creditCardOfferProvider = StateProvider<Map<String, dynamic>>((ref) => {
  'id': 'dfc_credit_card_2024',
  'title': 'Get your DFC Credit Card today!',
  'description': 'You are now eligible for an Instant Credit card with maximum limit upto 5,000.00 QAR.',
  'imagePath': 'assets/images/credit.png',
  'primaryButtonText': 'Apply now',
  'secondaryButtonText': 'Close',
  'showDontShowAgain': true,
  'cardType': 'Instant Credit Card',
});

// Offer visibility provider
final offerVisibilityProvider = StateProvider<Map<String, bool>>((ref) => {});

// Should show offer provider
final shouldShowOfferProvider = Provider.family<bool, String>((ref, offerId) {
  final visibilityMap = ref.watch(offerVisibilityProvider);
  return !(visibilityMap[offerId] ?? false);
});
