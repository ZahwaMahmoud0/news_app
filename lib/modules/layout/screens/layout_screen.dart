import 'package:flutter/material.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../home/home_page.dart';
import '../../../home/news_list_page.dart';
import '../../../home/search_page.dart';
import '../../models.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  CategoryModel? _category; 
  void _goHome() => setState(() => _category = null);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _category == null,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goHome(); 
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_category?.title ?? 'Home'),
          leading: Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SearchPage()),
              ),
            ),
          ],
        ),
        drawer: _AppDrawer(
          onGoHome: () {
            Navigator.of(context).pop(); // close drawer
            _goHome();
          },
        ),
        body: _category == null
            ? HomePage(onCategoryTap: (c) => setState(() => _category = c))
            : NewsListPage(key: ValueKey(_category!.id), category: _category!),
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final VoidCallback onGoHome;
  const _AppDrawer({required this.onGoHome});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: AppColors.black,
            alignment: Alignment.center,
            child: const Text('News App',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Go To Home'),
            onTap: onGoHome,
          ),
          const _SectionLabel(icon: Icons.palette_outlined, text: 'Theme'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ValueListenableBuilder<ThemeMode>(
              valueListenable: AppSettings.themeMode,
              builder: (_, mode, __) => DropdownButton<ThemeMode>(
                isExpanded: true,
                value: mode,
                items: const [
                  DropdownMenuItem(
                      value: ThemeMode.light, child: Text('Light')),
                  DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                ],
                onChanged: (v) {
                  if (v != null) AppSettings.themeMode.value = v;
                },
              ),
            ),
          ),
          const _SectionLabel(icon: Icons.language, text: 'Language'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ValueListenableBuilder<String>(
              valueListenable: AppSettings.language,
              builder: (_, lang, __) => DropdownButton<String>(
                isExpanded: true,
                value: lang,
                items: const [
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(value: 'Arabic', child: Text('Arabic')),
                ],
                onChanged: (v) {
                  if (v != null) AppSettings.language.value = v;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final IconData icon;
  final String text;
  const _SectionLabel({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
