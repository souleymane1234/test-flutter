import 'package:flutter/material.dart';
import 'package:test_app/features/articles/domain/entities/article.dart';
import 'package:test_app/features/articles/presentation/format_price.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
    required this.onFavorite,
  });

  final Article article;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final color = Color(article.color);
    final iconColor = color.computeLuminance() > 0.6
        ? const Color(0xFF222222)
        : Colors.white;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      article.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return ColoredBox(
                          color: color,
                          child: Center(
                            child: Icon(
                              Icons.checkroom,
                              size: 56,
                              color: iconColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: IconButton(
                        tooltip: article.isFavorite
                            ? 'Retirer des favoris'
                            : 'Ajouter aux favoris',
                        onPressed: onFavorite,
                        icon: Icon(
                          article.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: article.isFavorite
                              ? const Color(0xFFE11D48)
                              : const Color(0xFF222222),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatPrice(article.price),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
