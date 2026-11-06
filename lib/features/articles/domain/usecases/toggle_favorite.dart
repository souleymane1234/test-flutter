import 'package:test_app/core/result/result.dart';
import 'package:test_app/features/articles/domain/entities/article.dart';
import 'package:test_app/features/articles/domain/repositories/article_repository.dart';
import 'package:test_app/core/usecase/usecase.dart';

final class ToggleFavorite implements UseCase<List<Article>, String> {
  const ToggleFavorite(this._repository);

  final ArticleRepository _repository;

  @override
  Future<Result<List<Article>>> call(String articleId) {
    return _repository.toggleFavorite(articleId);
  }
}
