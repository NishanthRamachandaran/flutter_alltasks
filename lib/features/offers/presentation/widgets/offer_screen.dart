import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/features/offers/presentation/conroller/offer_provider.dart';

import '../widgets/custom_offer_dialog.dart';

@RoutePage() 
class OffersScreen extends ConsumerStatefulWidget {
  const OffersScreen({super.key});

  @override
  ConsumerState<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends ConsumerState<OffersScreen> {
  bool _isPopupShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isPopupShown) {
      final offer = ref.read(creditCardOfferProvider);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPopup(offer);
      });
      _isPopupShown = true;
    }
  }

  void _showPopup(Map<String, dynamic> offer) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => CustomOfferDialog(
        offerId: offer['id'],
        title: offer['title'],
        imagePath: offer['imagePath'],
        description: offer['description'],
        primaryButtonText: offer['primaryButtonText'],
        secondaryButtonText: offer['secondaryButtonText'],
        showDontShowAgain: offer['showDontShowAgain'],
        onPrimaryButtonPressed: () => Navigator.pop(context),
        onSecondaryButtonPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Offers Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
