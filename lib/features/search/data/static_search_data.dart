// lib/features/search/data/static_search_data.dart
class StaticSearchData {
  static final List<String> newUserServices = [
    "Mobile Recharge", "Track Billers", "Credit Card Bills", "Offers",
    "Your Cheque Book", "Electricity Bill", "Water Bill", "Gas Bill",
    "DTH Recharge", "Broadband Bill", "Insurance Premium", "Loan Payment",
  ];

  static final List<String> financialServices = [
    "Home Finance", "Instant Finance", "Car Finance", "Personal Finance",
    "Business Loans", "Investment Plans", "Loan Services", "Wealth Management",
    "Mortgage Services", "Credit Facilities", "Financial Planning", "Tax Services",
    "Insurance Products", "Retirement Planning", "Stock Trading", "Mutual Funds"
  ];

  static final List<Map<String, dynamic>> whatsNewFeatures = [
    {
      'id': '1',
      'title': 'Track Spends',
      'description': 'Monitor your expenses in real-time',
      'imagePath': 'assets/images/discovery.png',
      'type': 'spending_tracker',
    },
    {
      'id': '2',
      'title': 'Track Forex',
      'description': 'Live foreign exchange rates',
      'imagePath': 'assets/images/discovery.png',
      'type': 'forex_tracker',
    },
  ];

  static Future<List<String>> getSearchSuggestions(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // For returning user screen, use financial services
    final searchList = financialServices;
    
    if (query.isEmpty) return searchList;
    
    final lowerQuery = query.toLowerCase();
    return searchList.where((service) => 
      service.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  static Future<List<Map<String, dynamic>>> getWhatsNewFeatures() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return whatsNewFeatures;
  }

  // New method specifically for returning user search
  static Future<List<String>> getFinancialServices(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (query.isEmpty) return financialServices;
    
    final lowerQuery = query.toLowerCase();
    return financialServices.where((service) => 
      service.toLowerCase().contains(lowerQuery)
    ).toList();
  }
}