import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/news_provider.dart';
import '../utils/constants.dart';
import '../widgets/article_card.dart';
import '../widgets/featured_article_card.dart';
import '../widgets/error_view.dart';
import '../widgets/shimmer_loading.dart';

class NewsFeedBody extends StatefulWidget {
  const NewsFeedBody({super.key});

  @override
  State<NewsFeedBody> createState() => _NewsFeedBodyState();
}

class _NewsFeedBodyState extends State<NewsFeedBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: AppConstants.categories.length,
      vsync: this,
    );
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      final provider = Provider.of<NewsProvider>(context, listen: false);
      provider.setCategory(AppConstants.categories[_tabController.index]);
      _searchController.clear();
      setState(() {});
    }
  }

  void _onSearchChanged(String value) {
    // debounce search so we don't spam state updates on every keystroke
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (mounted) {
        Provider.of<NewsProvider>(context, listen: false).setSearchQuery(value);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // keep UI tabs in sync if category is updated from somewhere else (like sections screen)
    final providerCatIndex = AppConstants.categories.indexOf(
      provider.selectedCategory,
    );
    if (providerCatIndex >= 0 && _tabController.index != providerCatIndex) {
      _tabController.index = providerCatIndex;
    }

    return Column(
      children: [
        RepaintBoundary(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: List.generate(AppConstants.categories.length, (index) {
                final category = AppConstants.categories[index];
                final isSelected = _tabController.index == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(
                      _capitalize(category),
                      style: TextStyle(
                        color:
                            isSelected
                                ? (isDark ? Colors.black : Colors.white)
                                : (isDark ? Colors.white : Colors.black),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        _tabController.animateTo(index);
                      }
                    },
                    selectedColor: isDark ? Colors.white : Colors.black,
                    checkmarkColor: isDark ? Colors.black : Colors.white,
                    backgroundColor: Colors.transparent,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState:
              _isSearchVisible
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
          firstChild: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search by keyword, author, or title...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _searchController.clear();
                    _debounce?.cancel();
                    provider.setSearchQuery('');
                    setState(() => _isSearchVisible = false);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          secondChild: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (provider.lastUpdated != null &&
                    provider.articles.isNotEmpty)
                  Text(
                    'Updated ${DateFormat.jm().format(provider.lastUpdated!)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  )
                else
                  const SizedBox(),
                IconButton(
                  icon: const Icon(Icons.search, size: 22),
                  onPressed: () {
                    setState(() => _isSearchVisible = true);
                  },
                ),
              ],
            ),
          ),
        ),

        if (provider.availableLocations.isNotEmpty)
          RepaintBoundary(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              child: Row(
                children:
                    provider.availableLocations.map((location) {
                      final isSelected = provider.selectedLocation == location;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(
                            location,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : null,
                            ),
                          ),
                          selected: isSelected,
                          onSelected:
                              (_) => provider.setLocationFilter(location),
                          selectedColor:
                              isDark ? Colors.grey[700] : Colors.black87,
                          checkmarkColor: Colors.white,
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),

        Expanded(
          child: RefreshIndicator(
            onRefresh: () => provider.fetchArticles(refresh: true),
            child: Builder(
              builder: (context) {
                if (provider.isLoading && provider.articles.isEmpty) {
                  return const ShimmerLoading();
                }

                if (provider.error.isNotEmpty && provider.articles.isEmpty) {
                  return ErrorView(
                    message: provider.error,
                    onRetry: () => provider.fetchArticles(refresh: true),
                  );
                }

                if (provider.articles.isEmpty) {
                  return ListView(
                    children: const [
                      SizedBox(height: 100),
                      Center(
                        child: Text(
                          'No articles found matching your criteria.',
                        ),
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  cacheExtent: 500,
                  itemCount: provider.articles.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return RepaintBoundary(
                        child: FeaturedArticleCard(
                          article: provider.articles[index],
                        ),
                      );
                    }
                    return RepaintBoundary(
                      child: ArticleCard(
                        article: provider.articles[index],
                        index: index,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
