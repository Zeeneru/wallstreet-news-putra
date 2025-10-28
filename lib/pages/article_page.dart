import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  final Article article;
  const ArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title ?? '')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.author != null) Text('By ${article.author}'),
            if (article.publishedAt != null) Text('${article.publishedAt}'),
            const SizedBox(height: 12),
            Text(article.description ?? ''),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () async {
                final url = article.url;
                if (url != null && await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open original article'),
            )
          ],
        ),
      ),
    );
  }
}
