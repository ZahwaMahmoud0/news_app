import 'package:flutter/material.dart';


class AppSettings {
  static final themeMode = ValueNotifier<ThemeMode>(ThemeMode.dark);
  static final language = ValueNotifier<String>('English');
}
