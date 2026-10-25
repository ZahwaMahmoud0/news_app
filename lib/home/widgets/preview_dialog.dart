import 'package:flutter/material.dart';
import '../../modules/models.dart';
import '../../core/utils/launch_helper.dart';
import 'news_card.dart';

void showArticlePreview(BuildContext context, ArticleModel article) {
  final description = article.description ?? article.content ?? '';

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF171717),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArticleImage(url: article.imageUrl, height: 200),
              const SizedBox(height: 8),
              Text(article.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              const SizedBox(height: 6),
              Text(description,
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => openExternalUrl(context, article.url),
                  child: const Text('View Full Article'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}