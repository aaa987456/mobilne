import '../../../../../../core/constants/categories.dart';

abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetArticles extends RemoteArticleEvent {
  final bool isFirstPage;
  const GetArticles(this.isFirstPage);
}

class GetArticlesByCategory extends RemoteArticleEvent {
  final Category category;
  final bool isFirstPage;
  const GetArticlesByCategory(this.category, this.isFirstPage);
}

class SortByNewestDate extends RemoteArticleEvent {
  const SortByNewestDate();
}

class SortByOldestDate extends RemoteArticleEvent {
  const SortByOldestDate();
}

class GetArticleBySearchEvent extends RemoteArticleEvent {
  final String query;

  GetArticleBySearchEvent({required this.query});
}
