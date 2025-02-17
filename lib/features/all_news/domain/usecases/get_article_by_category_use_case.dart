import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/all_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/all_news/data/model/article.dart';
import 'package:news_app/features/all_news/domain/entities/article.dart';
import 'package:news_app/features/all_news/domain/repository/article_repository.dart';

import '../../../../core/constants/categories.dart';
import '../../../../core/resources/data_state.dart';

class GetArticleByCategoryUseCase extends Usecase<List<ArticleModel>, Test> {
  final ArticleRepository _articleRepository;

  GetArticleByCategoryUseCase(this._articleRepository);

  int _page = 0;
  List<ArticleModel> _articles = [];
  @override
  Future<List<ArticleModel>> call(Test test) async {
    dynamic response =
        await _articleRepository.getArticlesByCategory(test.params, _page);
    if (test.isFirstPage == true) {
      _page = 0;
      _articles = List.empty(growable: true);
    }

    if (response is DataSuccess) {
      _page++;
      List<ArticleModel> articles = response.data;
      List<ArticleModel> result = [];

      for (var element in articles) {
        if (element.urlToImage != null && element.urlToImage!.isNotEmpty) {
          result.add(element);
        }
      }
      _articles.addAll(result);
      return Future.value(_articles);
    }
    return response;
  }
}

class Test {
  final Category params;
  final bool isFirstPage;

  Test(Category category, {required this.params, required this.isFirstPage});
}
