import 'package:flutter/material.dart';
import '../modules/models.dart';
import 'widgets/news_card.dart';
import '../core/utils/launch_helper.dart';

class ArticlePage extends StatelessWidget {
  final ArticleModel article;
  const ArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final content = article.content
        ?.replaceAll(RegExp(r'\s?\[\+\d+ chars\]'), '')
        .trim();

    return Scaffold(
      appBar: AppBar(title: Text(article.sourceName)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(article.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('By: ${article.author ?? article.sourceName}',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(article.timeAgo,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 12),
          ArticleImage(url: article.imageUrl, height: 200),
          const SizedBox(height: 12),
          if (article.description != null)
            Text(article.description!,
                style: const TextStyle(fontSize: 14, height: 1.5)),
          if (content != null && content.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => openExternalUrl(context, article.url),
            child: const Text('Open original source'),
          ),
        ],
      ),
    );
  }
}
