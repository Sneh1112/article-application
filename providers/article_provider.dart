import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/article.dart';
import '../services/api_services.dart';

final articlesProvider = FutureProvider<List<Article>>((ref) async {
  try {
    return await ApiService.fetchArticles();
  } catch (e) {
    throw Exception('Error in provider: $e');
  }
});

final searchQueryProvider = StateProvider<String>((ref) => '');
