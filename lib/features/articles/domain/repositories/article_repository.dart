import 'package:test_app/core/result/result.dart';
import 'package:test_app/features/articles/domain/entities/article.dart';

abstract interface class ArticleRepository {
  Future<Result<List<Article>>> getArticles();

  Future<Result<List<Article>>> toggleFavorite(String articleId);
}
