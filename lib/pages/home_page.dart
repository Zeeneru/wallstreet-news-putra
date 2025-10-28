import 'package:flutter/material.dart';
import '../services/news_service.dart';
import '../models/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'article_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsService _newsService = NewsService();
  bool _loading = true;
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    setState(() => _loading = true);
    try {
      final articles = await _newsService.fetchFromWSJ();
      setState(() => _articles = articles);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WSJ News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadNews,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadNews,
              child: ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final a = _articles[index];
                  return ListTile(
                    leading: a.urlToImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: a.urlToImage!,
                              width: 90,
                              fit: BoxFit.cover,
                              placeholder: (c, _) => const SizedBox(
                                  width: 90,
                                  height: 60,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              errorWidget: (c, _, __) =>
                                  const Icon(Icons.broken_image),
                            ),
                          )
                        : const SizedBox(
                            width: 90, child: Icon(Icons.image_not_supported)),
                    title: Text(a.title ?? 'No title'),
                    subtitle: Text(a.sourceName ?? ''),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ArticlePage(article: a),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
