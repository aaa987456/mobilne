import 'package:news_app/features/all_news/domain/usecases/get_article.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/article.dart';
import '../repository/article_repository.dart';

class GetArticlesBySearchUsecase
    extends Usecase<DataState<List<ArticleEntity>>, String> {
  final ArticleRepository _articleRepository;

  GetArticlesBySearchUsecase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call(String params) {
    dynamic response = _articleRepository.getArticlesBySearch(params);
    if (response is DataSuccess) {
      List<ArticleEntity> articles = response.data;
      List<ArticleEntity> result = [];
      for (var element in articles) {
        if (element.urlToImage != null && element.urlToImage!.isNotEmpty) {
          result.add(element);
        }
      }
      return Future.value(DataSuccess(result));
    }

    return _articleRepository.getArticlesBySearch(params);
  }
}
