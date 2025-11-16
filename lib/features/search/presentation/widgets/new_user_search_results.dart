import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors/default_colors.dart';

class NewUserSearchResults extends StatelessWidget {
  final List<String> searchResults;
  final TextEditingController searchController;
  final double screenWidth;

  const NewUserSearchResults({
    super.key,
    required this.searchResults,
    required this.searchController,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (searchController.text.isEmpty) {
      return _buildEmptyState(context);
    }

    if (searchResults.isEmpty) {
      return _buildNoResults(context);
    }

    return Column(
    //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "Search Results",
        //   style: GoogleFonts.poppins(
        //     fontSize: screenWidth * 0.042,
        //     fontWeight: FontWeight.w600,
        //     color: DefaultColors.black,
        //   ),
        // ),
      //  SizedBox(height: screenWidth * 0.02),
        Expanded(
          child: ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return _buildSearchResultItem(context, searchResults[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResultItem(BuildContext context, String service) {
    final searchQuery = searchController.text.toLowerCase();
    
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.02),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DefaultColors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: DefaultColors.grayCA),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: searchQuery.isEmpty
                ? _buildNormalText(service)
                : _buildHighlightedText(service, searchQuery),
          ),
          Icon(
            Icons.north_east,
            size: screenWidth * 0.07,
            color: DefaultColors.blueBase,
          ),
        ],
      ),
    );
  }

  Widget _buildNormalText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: screenWidth * 0.035,
        fontWeight: FontWeight.w500,
        color: DefaultColors.blue9D,
      ),
    );
  }

  Widget _buildHighlightedText(String text, String query) {
    final textSpans = <TextSpan>[];
    final pattern = RegExp(query, caseSensitive: false);
    final matches = pattern.allMatches(text);
    int currentIndex = 0;
    
    for (final match in matches) {
      if (match.start > currentIndex) {
        textSpans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
            color: DefaultColors.blue9D,
          ),
        ));
      }
      
      textSpans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.035,
          fontWeight: FontWeight.w600,
          color: DefaultColors.blueBase,
        ),
      ));
      
      currentIndex = match.end;
    }
    
    if (currentIndex < text.length) {
      textSpans.add(TextSpan(
        text: text.substring(currentIndex),
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.035,
          fontWeight: FontWeight.w500,
          color: DefaultColors.blue9D,
        ),
      ));
    }
    
    return RichText(text: TextSpan(children: textSpans));
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: screenWidth * 0.2,
            color: DefaultColors.grayCA,
          ),
          SizedBox(height: screenWidth * 0.03),
          Text(
            "Search for services",
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.04,
              color: DefaultColors.gray62,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            "Try 'Mobile', 'Bills', 'Offers'",
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.032,
              color: DefaultColors.gray7D,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: screenWidth * 0.15,
            color: DefaultColors.grayCA,
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            "No results found for '${searchController.text}'",
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.04,
              color: DefaultColors.gray62,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            "Try different keywords or check spelling",
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.032,
              color: DefaultColors.gray7D,
            ),
          ),
        ],
      ),
    );
  }
}