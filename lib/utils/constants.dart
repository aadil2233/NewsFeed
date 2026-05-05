import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const String appName = 'Daily News';
  static String get nytApiKey => dotenv.env['NYT_API_KEY'] ?? '';
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
