

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors/default_colors.dart';
import '../../../../core/routes/app_route.gr.dart';
import '../../../offers/presentation/conroller/offer_provider.dart';
import '../../../offers/presentation/widgets/custom_offer_dialog.dart';
import '../widgets/customize_dashboard_card.dart';
import '../widgets/feedback_cards.dart';
import '../widgets/offer_section.dart';
import '../widgets/quick_action.dart';
import '../widgets/refer_earn_card.dart';
import '../widgets/rewards_section.dart';
import '../widgets/wealth_advisory_section.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isLoadingApi = false;
  bool _offerShown = false;

  @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _showCreditCardOffer();
  //   });
  // }

  void _showCreditCardOffer() {
    if (_offerShown) return; // Prevent multiple calls
    
    final offerData = ref.read(creditCardOfferProvider);
    final shouldShow = ref.read(shouldShowOfferProvider(offerData['id']));
    
    if (!shouldShow) return;

    _offerShown = true;

    // Show shimmer first
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => OfferShimmer(baseSize: 4.0),
    // );

    // After delay, show actual offer
    Future.delayed(Duration(seconds: 2), () {
      // Close shimmer
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      
      // Show actual offer
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CustomOfferDialog(
          offerId: offerData['id'],
          title: offerData['title'],
          imagePath: offerData['imagePath'],
          description: offerData['description'],
          primaryButtonText: offerData['primaryButtonText'],
          secondaryButtonText: offerData['secondaryButtonText'],
          showDontShowAgain: offerData['showDontShowAgain'],
          onPrimaryButtonPressed: () {
            Navigator.of(context).pop();
            _handlePrimaryAction(context, offerData);
          },
          onSecondaryButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    });
  }

  void _handlePrimaryAction(BuildContext context, Map<String, dynamic> offerData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting ${offerData['cardType']} application!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    // You can add navigation to application screen here
    // context.pushRoute(const CreditCardApplicationRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16, 
            vertical: 18
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              QuickActions(),
              SizedBox(height: 40), 
              OffersSection(),
              SizedBox(height: 40), 
              ReferEarnCard(),
              SizedBox(height: 20),
              RewardsSection(),
              
              // 🆕 Add Feedback Cards here
              SizedBox(height: 40),
              FeedbackCards(),
              
              const SizedBox(height: 40),
              CustomizeDashboardCard(),
              const SizedBox(height: 20),
              WealthAdvisorySection(),
              const SizedBox(height: 40),

            //  _buildNavigationSection(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildNavigationSection(BuildContext context) {
  //   final screenWidth = MediaQuery.of(context).size.width;
    
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       SizedBox(
  //         width: screenWidth * 0.9,
  //         height: 24,
  //         child: Text(
  //           "Navigate To Features", 
  //           style: GoogleFonts.poppins(
  //             fontSize: 19,
  //             fontWeight: FontWeight.w600,
  //             color: DefaultColors.black,
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 12),

  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Expanded(
  //             child: _navigationButton(
  //               context: context,
  //               title: "Search",
  //               icon: Icons.search,
  //               onTap: () => context.pushRoute(const UnifiedSearchRoute()),
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: _navigationButton(
  //               context: context,
  //               title: "Profile",
  //               icon: Icons.person,
  //               onTap: () => context.pushRoute(const ProfileRoute()),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget _navigationButton({
  //   required BuildContext context,
  //   required String title,
  //   required IconData icon,
  //   required VoidCallback onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         color: DefaultColors.whiteF3,
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             color: DefaultColors.black.withOpacity(0.03), // FIXED: Using DefaultColors
  //             blurRadius: 6,
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         children: [
  //           Icon(icon, size: 24, color: DefaultColors.blueLightBase),
  //           const SizedBox(height: 8),
  //           Text(
  //             title,
  //             style: GoogleFonts.poppins(
  //               fontWeight: FontWeight.w600,
  //               fontSize: 14,
  //               color: DefaultColors.black,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  }
