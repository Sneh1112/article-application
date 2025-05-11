import 'package:article_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import '../models/article.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article ${article.id}', style: AppStyles.detailScreen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article.title, style: AppStyles.detailScreenTitle),
            const SizedBox(height: 16),
            Text(article.body, style: AppStyles.detailScreenBody),
          ],
        ),
      ),
    );
  }
}
