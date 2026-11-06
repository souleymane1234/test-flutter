import 'package:test_app/features/articles/domain/entities/article.dart';

final class ArticleModel {
  const ArticleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.color,
    required this.isFavorite,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final int color;
  final bool isFavorite;

  Article toEntity() {
    return Article(
      id: id,
      name: name,
      description: description,
      price: price,
      image: image,
      color: color,
      isFavorite: isFavorite,
    );
  }

  ArticleModel copyWith({bool? isFavorite}) {
    return ArticleModel(
      id: id,
      name: name,
      description: description,
      price: price,
      image: image,
      color: color,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
