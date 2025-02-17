import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/all_news/data/model/article.dart';
import 'package:news_app/features/all_news/domain/entities/article.dart';
import 'package:news_app/features/all_news/domain/usecases/get_article.dart';
import 'package:news_app/features/all_news/domain/usecases/get_articles_by_search.dart';
import 'package:news_app/features/all_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/all_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../../domain/usecases/get_article_by_category_use_case.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;
  final GetArticleByCategoryUseCase _getArticleByCategoryUseCase;
  final GetArticlesBySearchUsecase _getArticlesBySearchUsecase;
  List<ArticleEntity> articles = [];
  RemoteArticleBloc(
      {required GetArticleUseCase getArticleUseCase,
      required GetArticlesBySearchUsecase getArticlesBySearch,
      required GetArticleByCategoryUseCase getArticleByCategoryUseCase})
      : _getArticleUseCase = getArticleUseCase,
        _getArticlesBySearchUsecase = getArticlesBySearch,
        _getArticleByCategoryUseCase = getArticleByCategoryUseCase,
        super(const RemoteArticleLoading()) {
    on<GetArticles>(onGetArticles);
    on<GetArticlesByCategory>(onGetArticlesByCategory);
    on<SortByNewestDate>(onSortByNewestDate);
    on<SortByOldestDate>(onSortByOldestDate);
    on<GetArticleBySearchEvent>(onGetSearchedArticles);
  }

  Future<void> onGetArticlesByCategory(
      GetArticlesByCategory event, Emitter<RemoteArticleState> emit) async {
    emit(ArticleCategoryLoadingState([]));
    final dataState = await _getArticleByCategoryUseCase(Test(event.category,
        params: event.category, isFirstPage: event.isFirstPage));

    if (dataState.isNotEmpty) {
      articles = List.of(dataState);
      emit(ArticleCategoryLoadedState(dataState));
    }
    if (dataState is DataError) {
      emit(ArticleCategoryErrorState([]));
    }
  }

  Future<void> onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase(event.isFirstPage);
    emit(RemoteArticleLoading(articles: articles));
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      articles = List.of(dataState.data!);
      emit(RemoteArticleLoaded(dataState.data!));
    }
    if (dataState is DataError) {
      emit(RemoteArticleError(dataState.error!));
    }
  }

  void onSortByNewestDate(
      SortByNewestDate event, Emitter<RemoteArticleState> emit) {
    emit(RemoteArticleLoading());
    final List<ArticleEntity> art = List.of(articles);
    art.sort((a, b) => b.publishedAt!.millisecondsSinceEpoch
        .compareTo(a.publishedAt!.millisecondsSinceEpoch));
    emit(RemoteArticleLoaded(art));
  }

  void onSortByOldestDate(
      SortByOldestDate event, Emitter<RemoteArticleState> emit) {
    emit(RemoteArticleLoading());
    final List<ArticleEntity> art = List.of(articles);

    art.sort((a, b) => a.publishedAt!.millisecondsSinceEpoch
        .compareTo(b.publishedAt!.millisecondsSinceEpoch));
    emit(RemoteArticleLoaded(art));
  }

  Future<void> onGetSearchedArticles(
      GetArticleBySearchEvent event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticlesBySearchUsecase(event.query);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      articles = List.of(dataState.data!);
      emit(ArticleSearchLoadedState(dataState.data!));
    }
    if (dataState is DataError) {
      emit(ArticleSearchErrorState(dataState.error!));
    }
  }
}
