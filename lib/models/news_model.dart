class NewsArticle {
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String category;
  final String? author;
  final String? publishedAt;

  NewsArticle({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.category,
    this.author,
    this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No title available',
      description: json['description'] ?? 'No description available',
      imageUrl: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      category: json['source']?['name'] ?? 'General',
      author: json['author'] ?? 'Unknown',
      publishedAt: json['publishedAt'],
    );
  }
}
