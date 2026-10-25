import 'package:flutter/material.dart';
import 'core/settings/app_settings.dart';
import 'core/theme/app_colors.dart';
import 'modules/splash/screens/splash_screen.dart';

void main() => runApp(const NewsApp());

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppSettings.themeMode,
      builder: (_, mode, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: mode,
        home: const SplashScreen(),
      ),
    );
  }
}
