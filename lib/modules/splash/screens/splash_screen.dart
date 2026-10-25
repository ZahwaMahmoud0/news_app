import 'package:flutter/material.dart';
import '../../layout/screens/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LayoutScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      body: SafeArea(
        child: Column(
          children: [
           
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/logo/news_logo.png',
                  width: 298,
                ),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Image.asset(
                'assets/logo/news_branding.png',
                width: 214,
              ),
            ),
          ],
        ),
      ),
    );
  }
}