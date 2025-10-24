import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/news_model.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;
  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.network(
            article.imageUrl,
            width: double.infinity,
            height: 171,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 171,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: const Icon(
                Icons.broken_image,
                color: Colors.grey,
                size: 40,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // 🔹 Text Section with SVG icon
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded text on the left
              Expanded(
                child: Text(
                  article.title,
                  style: const TextStyle(
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 20 / 16,
                    letterSpacing: 0,
                    color: Color(0xFF071A27),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              SvgPicture.asset(
                'assets/icons/Frame4.svg',
                width: 20, // adjust size as needed
                height: 20,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
