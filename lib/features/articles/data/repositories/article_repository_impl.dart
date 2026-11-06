import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/result/result.dart';
import 'package:test_app/features/articles/data/datasources/article_local_data_source.dart';
import 'package:test_app/features/articles/domain/entities/article.dart';
import 'package:test_app/features/articles/domain/repositories/article_repository.dart';

final class ArticleRepositoryImpl implements ArticleRepository {
  const ArticleRepositoryImpl(this._localDataSource);

  final ArticleLocalDataSource _localDataSource;

  @override
  Future<Result<List<Article>>> getArticles() async {
    try {
      final models = await _localDataSource.readAll();
      return Success(models.map((model) => model.toEntity()).toList());
    } catch (error) {
      return ResultFailure(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<Article>>> toggleFavorite(String articleId) async {
    try {
      final models = await _localDataSource.toggleFavorite(articleId);
      return Success(models.map((model) => model.toEntity()).toList());
    } catch (error) {
      return ResultFailure(Failure(error.toString()));
    }
  }
}
