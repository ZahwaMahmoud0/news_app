import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../modules/models.dart';

class NewsException implements Exception {
  final String message;
  const NewsException(this.message);

  @override
  String toString() => message;
}

class NewsService {
  static const String _apiKey = 'ede5f781fdaf4121ae52c1f8c14363a0';

  Future<Map<String, dynamic>> _get(
      String path, Map<String, String> params) async {
    final query = Map<String, String>.from(params);
    query['apiKey'] = _apiKey;
    final uri = Uri.https('newsapi.org', path, query);

    http.Response res;
    try {
      res = await http.get(uri).timeout(const Duration(seconds: 15));
    } catch (_) {
      throw const NewsException('No internet connection. Please try again.');
    }

    Map<String, dynamic> body;
    try {
      body = jsonDecode(res.body) as Map<String, dynamic>;
    } catch (_) {
      throw const NewsException('Unexpected response from the server.');
    }

    if (res.statusCode == 429) {
      throw const NewsException('Too many requests. Please try again later.');
    }
    if (res.statusCode != 200) {
      final msg = body['message'];
      throw NewsException(
          msg is String ? msg : 'Server error (${res.statusCode}).');
    }
    return body;
  }

  List<ArticleModel> _parseArticles(Map<String, dynamic> body) {
    final list = (body['articles'] as List<dynamic>? ?? []);
    return list
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .where((a) => a.title != '[Removed]' && a.url.isNotEmpty)
        .toList();
  }


  Future<List<ArticleModel>> searchNews(String query) async {
    final body = await _get('/v2/everything', {
      'q': query,
      'language': 'en',
      'sortBy': 'publishedAt',
      'pageSize': '30',
    });
    return _parseArticles(body);
  }

  Future<List<SourceModel>> getSources(String category) async {
    final body = await _get('/v2/top-headlines/sources', {
      'category': category,
      'language': 'en',
    });
    final list = (body['sources'] as List<dynamic>? ?? []);
    return list
        .map((e) => SourceModel.fromJson(e as Map<String, dynamic>))
        .where((s) => s.id.isNotEmpty)
        .toList();
  }

  
  Future<List<ArticleModel>> getHeadlines(String sourceId) async {
    final body = await _get('/v2/top-headlines', {
      'sources': sourceId,
      'pageSize': '30',
    });
    return _parseArticles(body);
  }
}