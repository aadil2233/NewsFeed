import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CacheService {
  Future<void> cacheArticles(String category, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();

    // Add timestamp to the cached data
    data['cached_at'] = DateTime.now().toIso8601String();

    await prefs.setString('cache_$category', json.encode(data));
  }

  Future<Map<String, dynamic>?> getCachedArticles(String category) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedString = prefs.getString('cache_$category');

    if (cachedString != null) {
      return json.decode(cachedString);
    }
    return null;
  }
}
