import 'package:equatable/equatable.dart';
import 'package:test_app/features/articles/domain/entities/article.dart';

sealed class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object?> get props => const [];
}

final class ArticlesInitial extends ArticlesState {
  const ArticlesInitial();
}

final class ArticlesLoadInProgress extends ArticlesState {
  const ArticlesLoadInProgress();
}

final class ArticlesLoadSuccess extends ArticlesState {
  const ArticlesLoadSuccess(this.articles);

  final List<Article> articles;

  @override
  List<Object?> get props => [articles];
}

final class ArticlesLoadFailure extends ArticlesState {
  const ArticlesLoadFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
