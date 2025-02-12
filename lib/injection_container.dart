import 'package:get_it/get_it.dart';
import 'package:news_app/features/all_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/all_news/data/repository/article_repository_implementation.dart';
import 'package:news_app/features/all_news/domain/repository/article_repository.dart';
import 'package:news_app/features/all_news/domain/usecases/get_article.dart';
import 'package:news_app/features/all_news/domain/usecases/get_article_by_category_use_case.dart';
import 'package:news_app/features/all_news/domain/usecases/get_articles_by_search.dart';
import 'package:news_app/features/all_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<NewsApiService>(() => NewsApiService());

  sl.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImplementation(newsApiService: sl()));

  //Usecases

  sl.registerLazySingleton<GetArticleUseCase>(() => GetArticleUseCase(sl()));
  sl.registerLazySingleton(() => GetArticleByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetArticlesBySearchUsecase(sl()));
  //Bloc

  sl.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(
      getArticleUseCase: sl(),
      getArticleByCategoryUseCase: sl(),
      getArticlesBySearch: sl()));
}
