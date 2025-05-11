import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  static Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        return jsonData.map((item) => Article.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load articles. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching articles: $e');
    }
  }
}
