import 'package:flutter/material.dart';
import '../core/services/news_service.dart';
import '../modules/models.dart';
import 'widgets/news_card.dart';
import 'widgets/preview_dialog.dart';
import 'widgets/state_views.dart';

enum _Status { idle, loading, success, empty, error }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  final _service = NewsService();

  _Status _status = _Status.idle;
  List<ArticleModel> _articles = [];
  String _error = '';
  int _requestId = 0; 

  Future<void> _search(String raw) async {
    final query = raw.trim();
    if (query.isEmpty) return;

    final id = ++_requestId;
    setState(() => _status = _Status.loading);

    try {
      final results = await _service.searchNews(query);
      if (!mounted || id != _requestId) return;
      setState(() {
        _articles = results;
        _status = results.isEmpty ? _Status.empty : _Status.success;
      });
    } catch (e) {
      if (!mounted || id != _requestId) return;
      setState(() {
        _error = e.toString();
        _status = _Status.error;
      });
    }
  }

  void _clear() {
    _controller.clear();
    _requestId++;
    setState(() {
      _articles = [];
      _status = _Status.idle;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          onSubmitted: _search,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search, size: 20),
            suffixIcon: _controller.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: _clear),
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_status) {
      case _Status.idle:
        return const MessageView(
            icon: Icons.search, text: 'Search for any news topic.');
      case _Status.loading:
        return const LoadingView();
      case _Status.empty:
        return const MessageView(
            icon: Icons.article_outlined,
            text: 'No articles found. Try a different keyword.');
      case _Status.error:
        return MessageView(
          icon: Icons.wifi_off,
          text: _error,
          actionLabel: 'Retry',
          onAction: () => _search(_controller.text),
        );
      case _Status.success:
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: _articles.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => NewsCard(
            article: _articles[i],
            onTap: () => showArticlePreview(context, _articles[i]),
          ),
        );
    }
  }
}
