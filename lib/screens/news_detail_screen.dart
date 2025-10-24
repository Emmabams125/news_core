import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String author;
  final String publishedAt;
  final String url;

  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.author,
    required this.publishedAt,
    required this.url,
  });

  void _launchURL() async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: colorScheme.onSurface,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset(
              'assets/icons/notification-bing.svg',
              height: 24, // optional, for sizing
              width: 24, // optional, for sizing
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ), // makes it match your theme color
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 220,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),

            // Title
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 8),

            // Meta info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  publishedAt,
                  style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                Text(
                  "Reporter: $author",
                  style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              description,
              style: textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color: colorScheme.onSurface.withOpacity(0.85),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
