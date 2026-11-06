import 'package:test_app/features/articles/data/models/article_model.dart';

abstract interface class ArticleLocalDataSource {
  Future<List<ArticleModel>> readAll();

  Future<List<ArticleModel>> toggleFavorite(String id);
}

final class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final List<ArticleModel> _articles = [
    const ArticleModel(
      id: 'hoodie',
      name: 'Hoodie oversize',
      description: 'Molleton épais, coupe large, vert forêt.',
      price: 1000,
      image: 'assets/images/Hoodie oversize.webp',
      color: 0xFF2F4A3C,
      isFavorite: false,
    ),
    const ArticleModel(
      id: 'jacket',
      name: 'Veste en cuir',
      description: 'Cuir souple, couleur olive, fermeture boutonnée.',
      price: 1290,
      image: 'assets/images/Veste en cuir.jpg',
      color: 0xFF6E6248,
      isFavorite: false,
    ),
    const ArticleModel(
      id: 'sneakers',
      name: 'Basket blanche',
      description: 'Sneaker minimaliste pour tous les jours.',
      price: 6900,
      image: 'assets/images/Basket blanche.webp',
      color: 0xFFE6E6E6,
      isFavorite: false,
    ),
    const ArticleModel(
      id: 'trench',
      name: 'Trench beige',
      description: 'Coupe droite, tissu léger, mi-saison.',
      price: 1490,
      image: 'assets/images/Trench beige.jpg',
      color: 0xFFD7CBB8,
      isFavorite: false,
    ),
    const ArticleModel(
      id: 'jeans',
      name: 'Jean droit',
      description: 'Denim brut, taille haute, jambe droite.',
      price: 5900,
      image: 'assets/images/Jean droit.jpg',
      color: 0xFF3E4C67,
      isFavorite: false,
    ),
    const ArticleModel(
      id: 'shirt',
      name: 'Chemise lin',
      description: 'Lin clair, col ouvert, porté sur peau.',
      price: 4500,
      image: 'assets/images/Chemise lin.jpg',
      color: 0xFFF4F1EA,
      isFavorite: false,
    ),
  ];

  @override
  Future<List<ArticleModel>> readAll() async {
    return List<ArticleModel>.unmodifiable(_articles);
  }

  @override
  Future<List<ArticleModel>> toggleFavorite(String id) async {
    final index = _articles.indexWhere((article) => article.id == id);
    if (index < 0) {
      throw StateError('Article introuvable');
    }
    final current = _articles[index];
    _articles[index] = current.copyWith(isFavorite: !current.isFavorite);
    return List<ArticleModel>.unmodifiable(_articles);
  }
}
