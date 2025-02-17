import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/all_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/all_news/data/model/article.dart';
import 'package:news_app/features/all_news/domain/entities/article.dart';
import 'package:news_app/features/all_news/domain/repository/article_repository.dart';

import '../../../../core/constants/categories.dart';

class ArticleRepositoryImplementation implements ArticleRepository {
  final NewsApiService newsApiService;
  ArticleRepositoryImplementation({required this.newsApiService});
  @override
  Future<DataState<List<ArticleModel>>> getArticles(int page) async {
    try {
      List<ArticleModel> articles = await newsApiService.getAllNews(page);
      return DataSuccess(articles);
    } on Exception catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getArticlesByCategory(
      Category category, int page) async {
    try {
      List<ArticleModel> articles =
          await newsApiService.getAllNewsByCategories(category, page);
      return DataSuccess(articles);
    } on Exception catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getArticlesBySearch(
      String query) async {
    try {
      List<ArticleModel> articles =
          await newsApiService.getAllSearchResults(query);
      return DataSuccess(articles);
    } on Exception catch (e) {
      return DataError(e);
    }
  }
}
