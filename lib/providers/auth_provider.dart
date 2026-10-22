import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { unauthenticated, loading, authenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus _status = AuthStatus.unauthenticated;
  String? _error;
  String _loggedInEmail = '';

  AuthStatus get status => _status;
  String? get error => _error;
  String get loggedInEmail => _loggedInEmail;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  AuthProvider() {
    _checkSession();
  }

  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null && token.isNotEmpty) {
      _loggedInEmail = prefs.getString('auth_email') ?? '';
      _status = AuthStatus.authenticated;
      notifyListeners();
    }
  }

  /// Simulates a login network call (replace with real HTTP call later)
  Future<bool> login(String email, String password) async {
    _status = AuthStatus.loading;
    _error = null;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Demo validation — accept any email + password >= 6 chars
    if (password.length < 6) {
      _error = 'Password must be at least 6 characters.';
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }

    // Save session
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', 'demo_token_${email.hashCode}');
    await prefs.setString('auth_email', email);

    _loggedInEmail = email;
    _status = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }

  /// Simulates a register network call
  Future<bool> register(String name, String email, String password) async {
    _status = AuthStatus.loading;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (password.length < 6) {
      _error = 'Password must be at least 6 characters.';
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }

    // Save session + user name
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', 'demo_token_${email.hashCode}');
    await prefs.setString('auth_email', email);
    await prefs.setString('userName', name);

    _loggedInEmail = email;
    _status = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('auth_email');
    _loggedInEmail = '';
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
