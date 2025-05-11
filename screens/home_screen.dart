import 'package:article_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/article_provider.dart';
import '../providers/favorites_provider.dart';
import 'detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(articlesProvider);
    final query = ref.watch(searchQueryProvider);
    final favorites = ref.watch(favoritesProvider);

    Future<void> refresh() async {
      ref.invalidate(articlesProvider);
    }

    return articlesAsync.when(
      data: (articles) {
        final filtered =
            articles.where((article) {
              final q = query.toLowerCase();
              return article.title.toLowerCase().contains(q) ||
                  article.body.toLowerCase().contains(q);
            }).toList();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Search Articles here',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  suffixIcon:
                      query.isNotEmpty
                          ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              searchController.clear();
                              ref.read(searchQueryProvider.notifier).state = '';
                            },
                          )
                          : null,
                ),
                onChanged:
                    (value) =>
                        ref.read(searchQueryProvider.notifier).state = value,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final article = filtered[index];
                    final isFav = favorites.contains(article.id);

                    return Card(
                      color: Colors.white,
                      elevation: 5,
                      shadowColor: Colors.deepPurple,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Colors.deepPurple.shade100,
                          width: 1,
                        ),
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
                        trailing: IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color:
                                isFav
                                    ? AppStyles.favActiveColor
                                    : AppStyles.favInactiveColor,
                          ),
                          onPressed:
                              () => ref
                                  .read(favoritesProvider.notifier)
                                  .toggleFavorite(article.id),
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
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
