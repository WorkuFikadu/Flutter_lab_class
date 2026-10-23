import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _userName = 'Worku Fikadu';
  String _userEmail = 'workufikadu@gmail.com';
  bool _notificationsEnabled = true;

  bool get isDarkMode => _isDarkMode;
  String get userName => _userName;
  String get userEmail => _userEmail;
  bool get notificationsEnabled => _notificationsEnabled;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _userName = prefs.getString('userName') ?? 'Worku Fikadu';
      _userEmail = prefs.getString('userEmail') ?? 'workufikadu@gmail.com';
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
    } catch (e) {
      debugPrint('Error loading settings from SharedPreferences: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', _isDarkMode);
    } catch (e) {
      debugPrint('Error saving isDarkMode: $e');
    }
  }

  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notifications', _notificationsEnabled);
    } catch (e) {
      debugPrint('Error saving notifications: $e');
    }
  }

  Future<void> updateProfile(String name, String email) async {
    _userName = name;
    _userEmail = email;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', name);
      await prefs.setString('userEmail', email);
    } catch (e) {
      debugPrint('Error saving profile: $e');
    }
  }
}
