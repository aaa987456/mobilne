import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/all_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/all_news/data/model/article.dart';
import 'package:news_app/features/all_news/domain/repository/article_repository.dart';

import '../../../../core/constants/categories.dart';
import '../../../../core/resources/data_state.dart';

class GetArticleByCategoryUseCase
    extends Usecase<List<ArticleModel>, Category> {
  final ArticleRepository _articleRepository;

  GetArticleByCategoryUseCase(this._articleRepository);

  @override
  Future<List<ArticleModel>> call(Category params) async {
    dynamic response = await _articleRepository.getArticlesByCategory(params);

    if (response is DataSuccess) {
      List<ArticleModel> articles = response.data;
      List<ArticleModel> result = [];
      for (var element in articles) {
        if (element.urlToImage != null && element.urlToImage!.isNotEmpty) {
          result.add(element);
        }
      }
      return result;
    }
    return response;
  }
}
