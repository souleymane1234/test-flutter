import 'package:equatable/equatable.dart';

sealed class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object?> get props => const [];
}

final class ArticlesStarted extends ArticlesEvent {
  const ArticlesStarted();
}

final class ArticleFavoriteToggled extends ArticlesEvent {
  const ArticleFavoriteToggled(this.articleId);

  final String articleId;

  @override
  List<Object?> get props => [articleId];
}
