import 'package:test_app/core/result/result.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/articles/domain/entities/article.dart';
import 'package:test_app/features/articles/domain/repositories/article_repository.dart';

final class GetArticles implements UseCase<List<Article>, NoParams> {
  const GetArticles(this._repository);

  final ArticleRepository _repository;

  @override
  Future<Result<List<Article>>> call(NoParams params) {
    return _repository.getArticles();
  }
}
