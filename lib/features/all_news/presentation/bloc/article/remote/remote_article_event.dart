import '../../../../../../core/constants/categories.dart';

abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetArticles extends RemoteArticleEvent {
  const GetArticles();
}

class GetArticlesByCategory extends RemoteArticleEvent {
  final Category category;

  const GetArticlesByCategory(this.category);
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
