import 'dart:math';

import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/all_news/domain/entities/article.dart';
import 'package:news_app/features/all_news/domain/repository/article_repository.dart';

import '../../../../core/resources/data_state.dart';

class GetArticleUseCase
    extends Usecase<DataState<List<ArticleEntity>>, NoParams> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call(NoParams params) async {
    dynamic response = await _articleRepository.getArticles();
    if (response is DataSuccess) {
      List<ArticleEntity> articles = response.data;
      List<ArticleEntity> result = [];
      for (var element in articles) {
        if (element.urlToImage != null && element.urlToImage!.isNotEmpty) {
          result.add(element);
        }
      }
      return DataSuccess(result);
    }
    return _articleRepository.getArticles();
  }
}

class NoParams {}
