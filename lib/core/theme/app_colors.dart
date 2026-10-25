import 'package:flutter/material.dart';

class AppColors {
  static const black = Color(0xFF111111);
  static const darkBackground = Color(0xFF121212);
  static const darkCard = Color(0xFF1E1E1E);
  static const grey = Color(0xFF9E9E9E);
}

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.black, brightness: Brightness.light),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),
  );

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white, brightness: Brightness.dark),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
  );
}
