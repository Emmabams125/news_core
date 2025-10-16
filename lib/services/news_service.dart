import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // <-- for kIsWeb
import '../models/news_model.dart';

class NewsService {
  static const _apiKey = '00ec1c6b91cb4aeaad7703b7e996c7ef';
  static const _baseUrl = 'https://newsapi.org/v2/top-headlines';

  static Future<List<NewsArticle>> fetchNews({
    String category = 'general',
  }) async {
    final originalUrl =
        '$_baseUrl?country=us&category=$category&apiKey=$_apiKey';

    //  If running on web, wrap request through a CORS proxy
    final url = kIsWeb
        ? Uri.parse(
            'https://api.allorigins.win/get?url=${Uri.encodeComponent(originalUrl)}',
          )
        : Uri.parse(originalUrl);

    try {
      print('️ Fetching: $url');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = kIsWeb
            ? jsonDecode(jsonDecode(response.body)['contents'])
            : jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          final articles = (jsonData['articles'] as List)
              .map((json) => NewsArticle.fromJson(json))
              .where((a) => a.title.isNotEmpty && a.imageUrl.isNotEmpty)
              .toList();

          print(' Loaded ${articles.length} articles');
          return articles;
        } else {
          print(' API Error: ${jsonData['message']}');
        }
      } else {
        print(' HTTP Error ${response.statusCode}');
      }
    } catch (e) {
      print('Exception fetching news: $e');
    }

    return [];
  }
}
