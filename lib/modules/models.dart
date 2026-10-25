class ArticleModel {
  final String sourceName;
  final String? author;
  final String title;
  final String? description;
  final String? content;
  final String url;
  final String? imageUrl;
  final DateTime? publishedAt;

  const ArticleModel({
    required this.sourceName,
    required this.title,
    required this.url,
    this.author,
    this.description,
    this.content,
    this.imageUrl,
    this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      sourceName: (json['source']?['name'] as String?) ?? 'Unknown',
      author: json['author'] as String?,
      title: (json['title'] as String?) ?? 'Untitled',
      description: json['description'] as String?,
      content: json['content'] as String?,
      url: (json['url'] as String?) ?? '',
      imageUrl: json['urlToImage'] as String?,
      publishedAt: DateTime.tryParse((json['publishedAt'] as String?) ?? ''),
    );
  }

  String get timeAgo {
    if (publishedAt == null) return '';
    final diff = DateTime.now().difference(publishedAt!);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    return '${diff.inDays} days ago';
  }
}

class SourceModel {
  final String id;
  final String name;
  const SourceModel({required this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: (json['id'] as String?) ?? '',
        name: (json['name'] as String?) ?? 'Unknown',
      );
}
class CategoryModel {
  final String id;
  final String title;
  final String image;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.image,
  });
}


const List<CategoryModel> categories = [
  CategoryModel(
    id: 'general',
    title: 'General',
    image: 'assets/categories/general.png',
  ),
  CategoryModel(
    id: 'business',
    title: 'Business',
    image: 'assets/categories/busniess.png',
  ),
  CategoryModel(
    id: 'sports',
    title: 'Sports',
    image: 'assets/categories/sport.png',
  ),
  CategoryModel(
    id: 'technology',
    title: 'Technology',
    image: 'assets/categories/technology.png',
  ),
  CategoryModel(
    id: 'entertainment',
    title: 'Entertainment',
    image: 'assets/categories/entertainment.png',
  ),
  CategoryModel(
    id: 'health',
    title: 'Health',
    image: 'assets/categories/helth.png',
  ),
  CategoryModel(
    id: 'science',
    title: 'Science',
    image: 'assets/categories/science.png',
  ),
];