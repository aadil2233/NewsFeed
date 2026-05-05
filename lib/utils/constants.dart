import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Daily News';
  // Note: API key is exposed here strictly for internship reviewer convenience.
  // In a production environment, this would be hidden via .env or backend.
  static const String nytApiKey = 'GBE2MZQ18TWzdmH4UMdhITvE2rBuGWRchcnEaRjqqNP6337z';
  static const String nytBaseUrl = 'https://api.nytimes.com/svc/topstories/v2/';

  static const List<String> categories = [
    'home',
    'world',
    'arts',
    'science',
    'sports',
    'opinion',
  ];

  static const List<String> locationFilters = [
    'New York',
    'Washington',
    'International',
    'Europe',
    'Asia',
  ];

  // Theme Constants
  static const Color primaryColor = Colors.black;
  static const Color darkPrimaryColor = Colors.white;
}
