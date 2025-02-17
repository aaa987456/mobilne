import 'package:equatable/equatable.dart';
import 'package:news_app/features/all_news/domain/entities/article.dart';

abstract class RemoteArticleState extends Equatable {
  final List<ArticleEntity> articles;
  final Exception? error;

  const RemoteArticleState({this.articles = const [], this.error});

  @override
  List<Object?> get props => [articles, error];
}

class RemoteArticleSuccess extends RemoteArticleState {
  const RemoteArticleSuccess({super.articles});
}

class RemoteArticleLoading extends RemoteArticleSuccess {
  const RemoteArticleLoading({super.articles});
}

class RemoteArticleLoaded extends RemoteArticleSuccess {
  const RemoteArticleLoaded(List<ArticleEntity> articles)
      : super(articles: articles);
}

class RemoteArticleError extends RemoteArticleState {
  const RemoteArticleError(Exception error) : super(error: error);
}

class ArticleCategoryLoadingState extends RemoteArticleLoaded {
  const ArticleCategoryLoadingState(super.articles);
}

class ArticleCategoryLoadedState extends RemoteArticleLoaded {
  const ArticleCategoryLoadedState(super.articles);
}

class ArticleCategoryErrorState extends RemoteArticleLoaded {
  const ArticleCategoryErrorState(super.error);
}

class ArticleSearchLoadingState extends RemoteArticleLoaded {
  const ArticleSearchLoadingState(super.articles);
}

class ArticleSearchLoadedState extends RemoteArticleLoaded {
  const ArticleSearchLoadedState(super.articles);
}

class ArticleSearchErrorState extends RemoteArticleError {
  const ArticleSearchErrorState(super.error);
}
