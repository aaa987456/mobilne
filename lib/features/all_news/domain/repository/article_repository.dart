import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/all_news/domain/entities/article.dart';

import '../../../../core/constants/categories.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getArticles();
  Future<DataState<List<ArticleEntity>>> getArticlesByCategory(
      Category category);
  Future<DataState<List<ArticleEntity>>> getArticlesBySearch(String query);
}
