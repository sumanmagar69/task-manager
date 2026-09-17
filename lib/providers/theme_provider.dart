import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;
  Future<void> load() async { final preferences = await SharedPreferences.getInstance(); _mode = preferences.getBool('darkMode') == true ? ThemeMode.dark : ThemeMode.light; notifyListeners(); }
  Future<void> toggle() async { _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark; notifyListeners(); final preferences = await SharedPreferences.getInstance(); await preferences.setBool('darkMode', _mode == ThemeMode.dark); }
}
