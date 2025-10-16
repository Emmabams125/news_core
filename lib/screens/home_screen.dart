import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../widgets/news_card.dart';
import '../widgets/category_chip.dart';
import 'news_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // 🕒 Helper to format “time ago” text
  String _formatTime(String? dateString) {
    try {
      final date = DateTime.parse(dateString!);
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inMinutes < 60) {
        return '${diff.inMinutes} mins ago';
      } else if (diff.inHours < 24) {
        return '${diff.inHours} hrs ago';
      } else {
        return '${diff.inDays} days ago';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsCtrl = Get.put(NewsController());
    final categories = ['All', 'Trending', 'Sport', 'Politics', 'Business'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👤 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/men/32.jpg',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Hi, Jay",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications_none, size: 26),
                ],
              ),
              const SizedBox(height: 20),

              // 📰 TITLE SECTION
              const Text(
                "Some News make\nPeople happy.",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Get the latest updates from around the world.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // 🔍 SEARCH BAR
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Trending, Sport, etc",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🏷️ CATEGORY CHIPS
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) {
                    return Obx(() {
                      final selected =
                          newsCtrl.selectedCategory.value == categories[i];
                      return AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: selected ? 1.05 : 1.0,
                        child: CategoryChip(
                          label: categories[i],
                          isSelected: selected,
                          onTap: () async {
                            print("Fetching category: ${categories[i]}");
                            newsCtrl.selectedCategory.value = categories[i];
                            await newsCtrl.fetchNewsByCategory(categories[i]);
                            print("✅ Done fetching ${categories[i]}");
                          },
                        ),
                      );
                    });
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemCount: categories.length,
                ),
              ),
              const SizedBox(height: 20),

              // 🗞️ NEWS LIST SECTION
              Expanded(
                child: Obx(() {
                  if (newsCtrl.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }

                  final articles = newsCtrl.articles;

                  if (articles.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: newsCtrl.refreshNews,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 200),
                          Center(
                            child: Text(
                              "No news available.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      print("🔄 Pull-to-refresh triggered");
                      await newsCtrl.refreshNews();
                      print("✅ Refresh complete");
                    },
                    color: Colors.blue,
                    strokeWidth: 2.5,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return GestureDetector(
                          onTap: () {
                            print("📰 Opening: ${article.title}");
                            Get.to(
                              () => NewsDetailScreen(
                                title: article.title,
                                imageUrl: article.imageUrl,
                                description: article.description,
                                url: article.url,
                                author: article.author ?? 'Unknown',
                                publishedAt: article.publishedAt != null
                                    ? _formatTime(article.publishedAt)
                                    : 'Unknown',
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: NewsCard(article: article),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
