import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../models/news_model.dart';
import 'news_card.dart';
import '../resources/app_colours.dart';

class HomeTopCarousel extends StatefulWidget {
  const HomeTopCarousel({super.key});

  @override
  State<HomeTopCarousel> createState() => _HomeTopCarouselState();
}

class _HomeTopCarouselState extends State<HomeTopCarousel> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  final RxInt _currentPage = 0.obs;
  final NewsController _newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_newsController.isLoading.value) {
        return const SizedBox(
          height: 257,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      // Limit to only 2 trending articles
      final trendingArticles = _newsController.articles.take(2).toList();

      if (trendingArticles.isEmpty) {
        return const SizedBox(
          height: 257,
          child: Center(child: Text("No trending news available.")),
        );
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 350.w,
            height: 268.h,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => _currentPage.value = index,
              children: [
                _buildIntroSection(),
                ...trendingArticles.map(
                  (article) => _buildTrendingSection(article),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage.value == index ? 10 : 8,
                  height: _currentPage.value == index ? 10 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage.value == index
                        ? AppColors.primaryPurple
                        : Colors.grey.shade400,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  // 🔹 Intro Slide
  Widget _buildIntroSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Container(
        width: 350.w,
        height: 257.h,
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Some News make\nPeople happy.",
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                      fontSize: 26.sp,
                      color: Color(0xFF071A27),
                      height: 1.2,
                    ),
                  ),
                ),
                Container(
                  height: 23.h,
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(40),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.local_fire_department_rounded,
                        color: Colors.orangeAccent,
                        size: 14,
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          "Hot News",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor...",
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 14.sp,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Single Trending Article Slide
  Widget _buildTrendingSection(NewsArticle article) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        height: 257.h, // match your slide height
        child: Stack(
          children: [
            // The actual news card
            Positioned.fill(child: NewsCard(article: article)),

            // Hot News tag at top-right
            Positioned(
              top: 12.h,
              right: 12.w,
              child: Container(
                height: 23.h,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF), // 20% opacity white
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      color: Colors.orangeAccent,
                      size: 14,
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        "Hot News",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF071A27),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
