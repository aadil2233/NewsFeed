import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 48,
            backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
            child: Icon(
              Icons.person,
              size: 48,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'News Reader',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Personalize your experience',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          // Settings Section
          _buildSectionHeader(context, 'PREFERENCES'),
          const SizedBox(height: 8),
          _buildSettingsTile(
            context,
            icon: isDark ? Icons.light_mode : Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: isDark ? 'Currently on' : 'Currently off',
            trailing: Switch(
              value: provider.isDarkTheme,
              onChanged: (_) => provider.toggleTheme(),
              activeColor: Colors.white,
              activeTrackColor: Colors.black,
            ),
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            context,
            icon: Icons.notifications_none,
            title: 'Notifications',
            subtitle: 'Breaking news alerts · Coming soon',
            trailing: Switch(
              value: false,
              onChanged: null,
              activeColor: Colors.white,
              activeTrackColor: Colors.black,
            ),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader(context, 'ABOUT'),
          const SizedBox(height: 8),
          _buildSettingsTile(
            context,
            icon: Icons.info_outline,
            title: 'App Version',
            subtitle: '1.0.0',
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            context,
            icon: Icons.description_outlined,
            title: 'Data Source',
            subtitle: 'New York Times Top Stories API',
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            context,
            icon: Icons.code,
            title: 'Built With',
            subtitle: 'Flutter + Provider',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          color: Colors.grey[500],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      leading: Icon(icon, color: isDark ? Colors.white : Colors.black),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
      ),
      trailing: trailing,
    );
  }
}
