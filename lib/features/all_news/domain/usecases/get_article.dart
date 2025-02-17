import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/all_news/data/model/article.dart';
import 'package:news_app/features/all_news/domain/entities/article.dart';
import 'package:news_app/features/all_news/domain/repository/article_repository.dart';

import '../../../../core/resources/data_state.dart';

class GetArticleUseCase extends Usecase<DataState<List<ArticleEntity>>, bool> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  int _page = 0;
  List<ArticleEntity> _articles = [];
  @override
  Future<DataState<List<ArticleEntity>>> call(bool isFirstPage) async {
    dynamic response = await _articleRepository.getArticles(_page);
    if (isFirstPage == true) {
      _page = 0;
      _articles = List.empty(growable: true);
    }
    if (response is DataSuccess) {
      _page++;
      List<ArticleEntity> articles = response.data;
      List<ArticleEntity> result = [];
      for (var element in articles) {
        if (element.urlToImage != null && element.urlToImage!.isNotEmpty) {
          result.add(element);
        }
      }
      _articles.addAll(result);
      return DataSuccess(_articles);
    }
    return _articleRepository.getArticles(_page);
  }
}

class NoParams {}
