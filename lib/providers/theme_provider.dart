import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CrazyThemeMode { system, light, dark }

class ThemeProvider extends ChangeNotifier {
  final String THEME = "theme";

  late SharedPreferences _prefs;

  CrazyThemeMode currentTheme = CrazyThemeMode.system;

  ThemeMode get themeMode {
    if (currentTheme.name == 'light') {
      return ThemeMode.light;
    } else if (currentTheme.name == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  bool get isDarkMode {
    if (currentTheme.name == 'light') {
      return false;
    } else if (currentTheme.name == 'dark') {
      return true;
    } else {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
  }

  void changeTheme() async {
    currentTheme = (currentTheme == CrazyThemeMode.light
        ? CrazyThemeMode.dark
        : CrazyThemeMode.light);
    _prefs.setString(THEME, currentTheme.name);
    notifyListeners();
  }

  void makeItAuto() async {
    currentTheme = CrazyThemeMode.system;
    _prefs.setString(THEME, currentTheme.name);
    notifyListeners();
  }

  void makeItNotAuto() async {
    currentTheme = CrazyThemeMode.light;
    _prefs.setString(THEME, currentTheme.name);
    notifyListeners();
  }

  initialize() async {
    _prefs = await SharedPreferences.getInstance();
    currentTheme =
        CrazyThemeMode.values.byName(_prefs.getString(THEME) ?? 'system');
    notifyListeners();
  }
}
