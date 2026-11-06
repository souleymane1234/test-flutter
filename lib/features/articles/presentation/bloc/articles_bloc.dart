import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/result/result.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/articles/domain/usecases/get_articles.dart';
import 'package:test_app/features/articles/domain/usecases/toggle_favorite.dart';
import 'package:test_app/features/articles/presentation/bloc/articles_event.dart';
import 'package:test_app/features/articles/presentation/bloc/articles_state.dart';

final class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc({
    required this.getArticles,
    required this.toggleFavorite,
  }) : super(const ArticlesInitial()) {
    on<ArticlesStarted>(_onStarted);
    on<ArticleFavoriteToggled>(_onFavoriteToggled);
  }

  final GetArticles getArticles;
  final ToggleFavorite toggleFavorite;

  Future<void> _onStarted(
    ArticlesStarted event,
    Emitter<ArticlesState> emit,
  ) async {
    emit(const ArticlesLoadInProgress());
    final result = await getArticles(const NoParams());
    switch (result) {
      case Success(:final value):
        emit(ArticlesLoadSuccess(value));
      case ResultFailure(:final failure):
        emit(ArticlesLoadFailure(failure.message));
    }
  }

  Future<void> _onFavoriteToggled(
    ArticleFavoriteToggled event,
    Emitter<ArticlesState> emit,
  ) async {
    final result = await toggleFavorite(event.articleId);
    switch (result) {
      case Success(:final value):
        emit(ArticlesLoadSuccess(value));
      case ResultFailure(:final failure):
        emit(ArticlesLoadFailure(failure.message));
    }
  }
}
