import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:section13/themes/dark_mode.dart';
import 'package:section13/themes/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode;

  ThemeProvider({this.isDarkMode = false}) {
    isDarkMode = isDarkMode;
  }
  void initializeTheme() async {
    // Load theme from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final storedMode = prefs.getBool('isDarkMode') ?? false;
    if (storedMode != isDarkMode) {
      // Update local state and themeData if stored value differs
      isDarkMode = storedMode;
      themeData = isDarkMode ? darkMode : lightMode;
      notifyListeners();
    }
  }

  final _prefs = SharedPreferences.getInstance();

  Future<bool> loadThemeFromPrefs() async {
    final prefs = await _prefs; // Await the SharedPreferences instance
    return prefs.getBool('isDarkMode') ??
        false; // Return stored value or default
  }

  /// toggleTheme
  void toggleTheme() {
    isDarkMode = !isDarkMode;
    themeData =
        isDarkMode ? darkMode : lightMode; // Set theme based on current state
    _prefs.then((prefs) =>
        prefs.setBool('isDarkMode', isDarkMode)); // Save to SharedPreferences
    notifyListeners();
  }

  /// light mode

  ThemeData _themeData = lightMode;

  /// get theme
  ThemeData get themeData => _themeData;

  /// dark mode

  bool get isDarkmode => _themeData == darkMode;

  /// set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    ///update ui
    notifyListeners();
  }
}
