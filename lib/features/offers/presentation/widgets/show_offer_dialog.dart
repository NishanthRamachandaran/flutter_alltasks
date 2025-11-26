// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../widgets/custom_offer_dialog.dart';

// void showOfferDialog({
//   required BuildContext context,
//   required WidgetRef ref,
//   required Map<String, dynamic> offer,
// }) {
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (_) => CustomOfferDialog(
//       offerId: offer['id'],
//       title: offer['title'],
//       imagePath: offer['imagePath'],
//       description: offer['description'],
//       primaryButtonText: offer['primaryButtonText'],
//       secondaryButtonText: offer['secondaryButtonText'],
//       showDontShowAgain: offer['showDontShowAgain'],
//       onPrimaryButtonPressed: () => Navigator.pop(context),
//       onSecondaryButtonPressed: () => Navigator.pop(context),
//     ),
//   );
// }
