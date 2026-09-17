import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData _theme(Brightness brightness) => ThemeData(useMaterial3: true, brightness: brightness, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff6750a4), brightness: brightness), inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()));
  static ThemeData get light => _theme(Brightness.light);
  static ThemeData get dark => _theme(Brightness.dark);
}
