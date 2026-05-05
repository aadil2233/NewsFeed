import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../utils/constants.dart';

class SectionsScreen extends StatelessWidget {
  final VoidCallback onCategorySelected;

  const SectionsScreen({super.key, required this.onCategorySelected});

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'home':
        return Icons.home;
      case 'world':
        return Icons.public;
      case 'arts':
        return Icons.palette;
      case 'science':
        return Icons.science;
      case 'sports':
        return Icons.sports_soccer;
      case 'opinion':
        return Icons.forum;
      default:
        return Icons.article;
    }
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Browse Sections',
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Explore news by category',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4,
              ),
              itemCount: AppConstants.categories.length,
              itemBuilder: (context, index) {
                final category = AppConstants.categories[index];
                return InkWell(
                  onTap: () {
                    final provider = Provider.of<NewsProvider>(
                      context,
                      listen: false,
                    );
                    provider.setCategory(category);
                    onCategorySelected(); // Jump back to HOME tab
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getIconForCategory(category),
                          size: 36,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _capitalize(category),
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
