import 'package:get_it/get_it.dart';
import 'package:test_app/features/articles/data/datasources/article_local_data_source.dart';
import 'package:test_app/features/articles/data/datasources/order_api_data_source.dart';
import 'package:test_app/features/articles/data/repositories/article_repository_impl.dart';
import 'package:test_app/features/articles/data/repositories/order_repository_impl.dart';
import 'package:test_app/features/articles/domain/repositories/article_repository.dart';
import 'package:test_app/features/articles/domain/repositories/order_repository.dart';
import 'package:test_app/features/articles/domain/usecases/get_articles.dart';
import 'package:test_app/features/articles/domain/usecases/submit_order.dart';
import 'package:test_app/features/articles/domain/usecases/toggle_favorite.dart';
import 'package:test_app/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:test_app/features/articles/presentation/bloc/order_bloc.dart';

final GetIt sl = GetIt.instance;

void configureDependencies() {
  sl
    ..registerFactory(
      () => ArticlesBloc(
        getArticles: sl(),
        toggleFavorite: sl(),
      ),
    )
    ..registerFactory(() => OrderBloc(submitOrder: sl()))
    ..registerLazySingleton(() => GetArticles(sl()))
    ..registerLazySingleton(() => ToggleFavorite(sl()))
    ..registerLazySingleton(() => SubmitOrder(sl()))
    ..registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(sl()),
    )
    ..registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(sl()),
    )
    ..registerLazySingleton<ArticleLocalDataSource>(
      ArticleLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<OrderApiDataSource>(OrderApi.new);
}
