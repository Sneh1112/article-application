import 'package:article_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/article_provider.dart';
import '../providers/favorites_provider.dart';
import 'detail_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(articlesProvider);
    final favoriteIds = ref.watch(favoritesProvider);

    return articlesAsync.when(
      data: (articles) {
        final favorites =
            articles.where((a) => favoriteIds.contains(a.id)).toList();

        if (favorites.isEmpty) {
          return const Center(child: Text('No favorites'));
        }

        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final article = favorites[index];
            return Card(
              color: Colors.white,
              elevation: 5,
              shadowColor: Colors.deepPurple,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.deepPurple.shade100, width: 1),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Colors.deepPurple.shade300,
                title: Text(article.title, style: AppStyles.titleStyle),
                subtitle: Text(
                  article.body.length > 50
                      ? '${article.body.substring(0, 50)}...'
                      : article.body,
                  style: AppStyles.listTileSubtitle,
                ),

                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(article: article),
                      ),
                    ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
