import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../modules/models.dart';

class ArticleImage extends StatelessWidget {
  final String? url;
  final double height;
  final double radius;
  const ArticleImage({super.key, this.url, this.height = 150, this.radius = 10});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      height: height,
      width: double.infinity,
      color: Colors.grey.shade800,
      child: const Icon(Icons.image_not_supported_outlined, color: Colors.white54),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: (url == null || url!.isEmpty)
          ? placeholder
          : Image.network(
              url!,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) =>
                  progress == null ? child : placeholder,
              errorBuilder: (_, __, ___) => placeholder,
            ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onTap;
  const NewsCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDarkTheme ? AppColors.darkCard : AppColors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArticleImage(url: article.imageUrl, height: 140),
            const SizedBox(height: 8),
            Text(article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'By: ${article.author ?? article.sourceName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.grey, fontSize: 10),
                  ),
                ),
                const SizedBox(width: 8),
                Text(article.timeAgo,
                    style: const TextStyle(color: AppColors.grey, fontSize: 10)),
                    
              ],
            ),
          ],
        ),
      ),
    );
  }
}
