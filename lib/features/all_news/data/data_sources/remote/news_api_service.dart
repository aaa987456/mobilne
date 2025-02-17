import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/features/all_news/data/model/article.dart';

import '../../../../../core/constants/categories.dart';
import '../../../../../core/constants/constants.dart';

class NewsApiService {
  final http.Client client = http.Client();

  Future<List<ArticleModel>> getAllNews(int page) async {
    final response = await client.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey&page=$page&pageSize=10'));
    if (response.statusCode == 200) {
      final List<dynamic> news = json.decode(response.body)['articles'];
      return news.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<ArticleModel>> getAllNewsByCategories(
      Category category, int page) async {
    final response = await client.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=${category.name}&apiKey=$apiKey&page=$page&pageSize=10'));
    if (response.statusCode == 200) {
      final List<dynamic> news = json.decode(response.body)['articles'];
      return news.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<ArticleModel>> getAllSearchResults(String query) async {
    final response = await client.get(
        Uri.parse('https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> news = json.decode(response.body)['articles'];
      return news.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
