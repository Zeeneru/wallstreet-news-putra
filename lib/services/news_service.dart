import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsService {
  // Your API key (you provided it)
  final String apiKey = '0399de3c50c442559f1335c2451695da';

  Future<List<Article>> fetchFromWSJ({int pageSize = 20}) async {
  final uri = Uri.https('newsapi.org', '/v2/everything', {
    'domains': 'wsj.com',
    'pageSize': pageSize.toString(),
    'apiKey': apiKey,
  });

  final res = await http.get(uri);
  if (res.statusCode != 200) {
    throw Exception('Failed to fetch WSJ news: ${res.body}');
  }

  final Map<String, dynamic> data = json.decode(res.body);
  if (data['status'] != 'ok') {
    throw Exception('API error: ${data['message'] ?? 'unknown'}');
  }

  final List articles = data['articles'] as List;
  return articles.map((a) => Article.fromJson(a)).toList();
}

}
