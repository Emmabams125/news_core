import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../widgets/home_top_carousal.dart';
import '../widgets/news_card.dart';
import '../widgets/category_chip.dart';
import 'news_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: Obx(() {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
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
                          style: const TextStyle(
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700, // Bold (700)
                            fontSize: 24,
                            height: 1.0,
                            letterSpacing: 0,
                            color: Color(0xFF071A27),
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset('assets/icons/notification-bing.svg'),
                  ],
                ),

                const SizedBox(height: 20),

                // TOP CAROUSEL
                const HomeTopCarousel(),

                const SizedBox(height: 20),

                // SEARCH BAR
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0), // adjust for spacing
                      child: SvgPicture.asset(
                        'assets/icons/search-normal.svg',
                        width: 20, // now works
                        height: 20, // now works
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    hintText: "Trending, Sport, etc",
                    hintStyle: const TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // CATEGORY CHIPS
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) {
                      final selected =
                          newsCtrl.selectedCategory.value == categories[i];
                      return AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: selected ? 1.05 : 1.0,
                        child: CategoryChip(
                          label: categories[i],
                          isSelected: selected,
                          onTap: () async {
                            newsCtrl.selectedCategory.value = categories[i];
                            await newsCtrl.fetchNewsByCategory(categories[i]);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: categories.length,
                  ),
                ),

                const SizedBox(height: 20),

                // NEWS LIST
                if (newsCtrl.isLoading.value)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                else if (newsCtrl.articles.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Center(
                      child: Text(
                        "No news available.",
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  )
                else
                  Column(
                    children: newsCtrl.articles.map((article) {
                      return GestureDetector(
                        onTap: () {
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
                    }).toList(),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
