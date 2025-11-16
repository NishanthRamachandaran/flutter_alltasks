// search_option_item.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchOptionItem extends StatelessWidget {
  final String option;
  final VoidCallback onTap;

  const SearchOptionItem({
    super.key,
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.north_east,
                size: 18,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}