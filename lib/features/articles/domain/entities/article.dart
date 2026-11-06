import 'package:equatable/equatable.dart';

final class Article extends Equatable {
  const Article({
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

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    image,
    color,
    isFavorite,
  ];
}
