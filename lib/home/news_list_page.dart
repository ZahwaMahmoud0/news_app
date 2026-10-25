import 'package:flutter/material.dart';
import '../core/services/news_service.dart';
import '../modules/models.dart';
import 'widgets/news_card.dart';
import 'widgets/preview_dialog.dart';
import 'widgets/state_views.dart';

enum _Status { loading, success, empty, error }

class NewsListPage extends StatefulWidget {
  final CategoryModel category;
  const NewsListPage({super.key, required this.category});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final _service = NewsService();
  List<SourceModel> _sources = [];
  List<ArticleModel> _articles = [];
  int _selected = 0;
  _Status _status = _Status.loading;
  String _error = '';
  int _requestId = 0;

  @override
  void initState() {
    super.initState();
    _loadSources();
  }

  Future<void> _loadSources() async {
    setState(() => _status = _Status.loading);
    try {
      final sources = await _service.getSources(widget.category.id);
      if (!mounted) return;
      if (sources.isEmpty) {
        setState(() => _status = _Status.empty);
        return;
      }
      _sources = sources.take(15).toList();
      _selected = 0;
      await _loadArticles();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _status = _Status.error;
      });
    }
  }

  Future<void> _loadArticles() async {
    final id = ++_requestId;
    setState(() => _status = _Status.loading);
    try {
      final list = await _service.getHeadlines(_sources[_selected].id);
      if (!mounted || id != _requestId) return;
      setState(() {
        _articles = list;
        _status = list.isEmpty ? _Status.empty : _Status.success;
      });
    } catch (e) {
      if (!mounted || id != _requestId) return;
      setState(() {
        _error = e.toString();
        _status = _Status.error;
      });
    }
  }

  void _retry() => _sources.isEmpty ? _loadSources() : _loadArticles();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_sources.isNotEmpty) _buildTabs(),
        Expanded(child: _buildBody()),
      ],
    );
  }

  Widget _buildTabs() {
    final color = Theme.of(context).colorScheme.onSurface;
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _sources.length,
        itemBuilder: (_, i) {
          final selected = i == _selected;
          return GestureDetector(
            onTap: () {
              if (i == _selected) return;
              setState(() => _selected = i);
              _loadArticles();
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selected ? color : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                _sources[i].name,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? color : Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_status) {
      case _Status.loading:
        return const LoadingView();
      case _Status.empty:
        return const MessageView(
            icon: Icons.article_outlined, text: 'No articles found.');
      case _Status.error:
        return MessageView(
          icon: Icons.wifi_off,
          text: _error,
          actionLabel: 'Retry',
          onAction: _retry,
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
