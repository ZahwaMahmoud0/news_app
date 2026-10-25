import 'package:flutter/material.dart';
import '../modules/models.dart';
import 'widgets/category_card.dart';

class HomePage extends StatelessWidget {
  final ValueChanged<CategoryModel> onCategoryTap;
  const HomePage({super.key, required this.onCategoryTap});

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(_greeting,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('Here is Some News For You',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        for (var i = 0; i < categories.length; i++)
          CategoryCard(
            category: categories[i],
            index: i,
            onTap: () => onCategoryTap(categories[i]),
          ),
      ],
    );
  }
}
