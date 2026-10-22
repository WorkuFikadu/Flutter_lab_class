import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Settings',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Customize your experience',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6))),
              const SizedBox(height: 24),

              _buildSection(
                context,
                'Appearance',
                [
                  _SettingsTile(
                    icon: Icons.dark_mode_outlined,
                    iconColor: Colors.indigo,
                    title: 'Dark Mode',
                    subtitle: 'Switch to dark theme',
                    trailing: Switch.adaptive(
                      value: settings.isDarkMode,
                      onChanged: (_) => settings.toggleDarkMode(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildSection(
                context,
                'Notifications',
                [
                  _SettingsTile(
                    icon: Icons.notifications_outlined,
                    iconColor: Colors.orange,
                    title: 'Push Notifications',
                    subtitle: 'Receive app notifications',
                    trailing: Switch.adaptive(
                      value: settings.notificationsEnabled,
                      onChanged: (_) => settings.toggleNotifications(),
                    ),
                  ),
                  _SettingsTile(
                    icon: Icons.email_outlined,
                    iconColor: Colors.blue,
                    title: 'Email Alerts',
                    subtitle: 'Get important updates by email',
                    trailing: Switch.adaptive(
                      value: true,
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildSection(
                context,
                'Privacy',
                [
                  _SettingsTile(
                    icon: Icons.fingerprint,
                    iconColor: Colors.green,
                    title: 'Biometric Login',
                    subtitle: 'Use fingerprint or Face ID',
                    trailing: Switch.adaptive(
                      value: false,
                      onChanged: (_) {},
                    ),
                  ),
                  _SettingsTile(
                    icon: Icons.lock_outline,
                    iconColor: Colors.red,
                    title: 'Change Password',
                    subtitle: 'Update your password',
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () => _showChangePasswordDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildSection(
                context,
                'General',
                [
                  _SettingsTile(
                    icon: Icons.language,
                    iconColor: Colors.teal,
                    title: 'Language',
                    subtitle: 'English (US)',
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  ),
                  _SettingsTile(
                    icon: Icons.storage_outlined,
                    iconColor: Colors.brown,
                    title: 'Clear Cache',
                    subtitle: 'Free up storage space',
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () => _showClearCacheDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // App version
              Center(
                child: Text('Version 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.4))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<_SettingsTile> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: tiles.asMap().entries.map((entry) {
              final i = entry.key;
              final tile = entry.value;
              return Column(
                children: [
                  ListTile(
                    onTap: tile.onTap,
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: tile.iconColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(tile.icon, color: tile.iconColor, size: 20),
                    ),
                    title: Text(tile.title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500)),
                    subtitle: Text(tile.subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.55))),
                    trailing: tile.trailing,
                  ),
                  if (i < tiles.length - 1)
                    const Divider(height: 1, indent: 56),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Current Password',
                  prefixIcon: Icon(Icons.lock_outline)),
            ),
            SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: Icon(Icons.lock)),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Update')),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Clear Cache'),
        content: const Text('This will free up storage. Your data will not be deleted.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache cleared successfully'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });
}
