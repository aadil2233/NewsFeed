import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

class NewsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final CacheService _cacheService = CacheService();

  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  List<Article> _savedArticles = [];

  bool _isLoading = false;
  String _error = '';
  String _selectedCategory = 'home';
  String _searchQuery = '';
  String _selectedLocation = '';
  DateTime? _lastUpdated;
  bool _isDarkTheme = false;

  List<Article> get articles => _filteredArticles;
  List<Article> get savedArticles => _savedArticles;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String get selectedLocation => _selectedLocation;
  DateTime? get lastUpdated => _lastUpdated;
  bool get isDarkTheme => _isDarkTheme;

  List<String> get availableLocations {
    final Map<String, int> locCounts = {};
    for (var article in _articles) {
      for (var loc in article.locations) {
        locCounts[loc] = (locCounts[loc] ?? 0) + 1;
      }
    }
    final sortedLocs =
        locCounts.keys.toList()
          ..sort((a, b) => locCounts[b]!.compareTo(locCounts[a]!));
    return sortedLocs.take(8).toList();
  }

  NewsProvider() {
    fetchArticles();
    _loadSavedArticles();
  }

  // ---- Bookmark / Save ----

  bool isArticleSaved(Article article) {
    return _savedArticles.any((a) => a.url == article.url);
  }

  Future<void> toggleSaveArticle(Article article) async {
    if (isArticleSaved(article)) {
      _savedArticles.removeWhere((a) => a.url == article.url);
    } else {
      _savedArticles.add(article);
    }
    notifyListeners();
    await _persistSavedArticles();
  }

  Future<void> _loadSavedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('saved_articles');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _savedArticles = jsonList.map((j) => Article.fromJson(j)).toList();
      notifyListeners();
    }
  }

  Future<void> _persistSavedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _savedArticles.map((a) => a.toJson()).toList();
    await prefs.setString('saved_articles', jsonEncode(jsonList));
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  void setCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    _searchQuery = '';
    _selectedLocation = '';
    _articles = []; // Clear previous articles to show shimmer
    _filteredArticles = [];
    fetchArticles();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setLocationFilter(String location) {
    if (_selectedLocation == location) {
      _selectedLocation = '';
    } else {
      _selectedLocation = location;
    }
    _applyFilters();
  }

  void _applyFilters() {
    _filteredArticles =
        _articles.where((article) {
          final matchesSearch =
              _searchQuery.isEmpty ||
              article.title.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              article.abstractText.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              article.byline.toLowerCase().contains(_searchQuery.toLowerCase());

          final matchesLocation =
              _selectedLocation.isEmpty ||
              article.locations.any(
                (loc) =>
                    loc.toLowerCase().contains(_selectedLocation.toLowerCase()),
              );

          return matchesSearch && matchesLocation;
        }).toList();
    notifyListeners();
  }

  Future<void> fetchArticles({bool refresh = false}) async {
    final fetchCategory = _selectedCategory;
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      if (!refresh) {
        final cachedData = await _cacheService.getCachedArticles(fetchCategory);
        if (cachedData != null) {
          final cachedAt = DateTime.tryParse(cachedData['cached_at'] ?? '');

          if (cachedAt != null &&
              DateTime.now().difference(cachedAt).inMinutes < 60) {
            if (_selectedCategory != fetchCategory)
              return; // Prevent race condition

            _processData(cachedData, isCached: true);
            _isLoading = false;
            notifyListeners();
            return;
          } else {
            if (_selectedCategory == fetchCategory) {
              _processData(cachedData, isCached: true);
            }
          }
        }
      }

      final data = await _apiService.fetchTopStories(fetchCategory);

      if (_selectedCategory != fetchCategory)
        return; // Abort if user switched tabs

      await _cacheService.cacheArticles(fetchCategory, data);
      _processData(data);
      _error = '';
    } catch (e) {
      if (_selectedCategory != fetchCategory) return;

      final cachedData = await _cacheService.getCachedArticles(fetchCategory);
      if (cachedData != null) {
        _processData(cachedData, isCached: true);
        _error =
            'Using offline cache. ${e.toString().replaceAll('Exception: ', '')}';
      } else {
        _error = e.toString().replaceAll('Exception: ', '');
        _articles = [];
        _filteredArticles = [];
      }
    } finally {
      if (_selectedCategory == fetchCategory) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  void _processData(Map<String, dynamic> data, {bool isCached = false}) {
    if (data['results'] != null) {
      final List<dynamic> results = data['results'];
      _articles =
          results
              .map((json) => Article.fromJson(json))
              .where((article) => article.title.isNotEmpty)
              .toList();
      _applyFilters();

      if (isCached && data['cached_at'] != null) {
        _lastUpdated = DateTime.parse(data['cached_at']);
      } else {
        _lastUpdated = DateTime.now();
      }
    }
  }
}
