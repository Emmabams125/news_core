import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsController extends GetxController {
  final articles = <NewsArticle>[].obs;
  final isLoading = false.obs;
  final selectedCategory = 'All'.obs;

  final String apiKey = '00ec1c6b91cb4aeaad7703b7e996c7ef';

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  /// Fetches top headlines (default feed)
  Future<void> fetchNews() async {
    isLoading.value = true;
    final defaultUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    print(" Fetching default news from: $defaultUrl");

    try {
      final res = await http.get(Uri.parse(defaultUrl));
      final data = jsonDecode(res.body);

      print("Response status: ${res.statusCode}");
      if (res.statusCode == 200 && data['articles'] != null) {
        articles.value = (data['articles'] as List)
            .map((e) => NewsArticle.fromJson(e))
            .toList();
        print(" Default fetched ${articles.length} articles");
      } else {
        articles.clear();
        print(" articles found in default feed");
      }
    } catch (e) {
      print(" Error fetching news: $e");
      articles.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetches category-based news using hybrid logic
  Future<void> fetchNewsByCategory(String category) async {
    isLoading.value = true;
    String url;

    if (category == 'All') {
      url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';
    } else if (category == 'Trending') {
      url =
          'https://newsapi.org/v2/top-headlines?country=us&sortBy=popularity&apiKey=$apiKey';
    } else {
      // Use keyword search for better results in other categories
      url =
          'https://newsapi.org/v2/everything?q=${category.toLowerCase()}&language=en&sortBy=publishedAt&apiKey=$apiKey';
    }

    print("Fetching category: $category → $url");

    try {
      final res = await http.get(Uri.parse(url));
      final data = jsonDecode(res.body);

      print("Response status for $category: ${res.statusCode}");
      if (res.statusCode == 200 && data['articles'] != null) {
        final fetched = (data['articles'] as List)
            .map((e) => NewsArticle.fromJson(e))
            .toList();

        articles.value = fetched;
        print(" ${fetched.length} articles fetched for $category");
      } else {
        articles.clear();
        print(" No articles found for $category");
      }
    } catch (e) {
      print(" Error fetching $category news: $e");
      articles.clear();
    } finally {
      isLoading.value = false;
      print(" Done fetching $category");
    }
  }

  /// Pull-to-refresh support
  Future<void> refreshNews() async {
    print(" Refreshing current category: ${selectedCategory.value}");
    await fetchNewsByCategory(selectedCategory.value);
  }
}
