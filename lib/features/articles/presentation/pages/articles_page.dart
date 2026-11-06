import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/di/injection.dart';
import 'package:test_app/features/articles/domain/entities/article.dart';
import 'package:test_app/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:test_app/features/articles/presentation/bloc/articles_event.dart';
import 'package:test_app/features/articles/presentation/bloc/articles_state.dart';
import 'package:test_app/features/articles/presentation/bloc/order_bloc.dart';
import 'package:test_app/features/articles/presentation/pages/payment_page.dart';
import 'package:test_app/features/articles/presentation/widgets/article_card.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: BlocBuilder<ArticlesBloc, ArticlesState>(
        builder: (context, state) {
          return switch (state) {
            ArticlesInitial() || ArticlesLoadInProgress() => const Center(
              child: CircularProgressIndicator(),
            ),
            ArticlesLoadFailure(:final message) => Center(child: Text(message)),
            ArticlesLoadSuccess(:final articles) => _ArticleGrid(
              articles: articles,
            ),
          };
        },
      ),
    );
  }
}

class _ArticleGrid extends StatelessWidget {
  const _ArticleGrid({required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1000 ? 4 : (width >= 700 ? 3 : 2);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ArticleCard(
          article: article,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => BlocProvider(
                  create: (_) => sl<OrderBloc>(),
                  child: PaymentPage(article: article),
                ),
              ),
            );
          },
          onFavorite: () {
            context.read<ArticlesBloc>().add(
              ArticleFavoriteToggled(article.id),
            );
          },
        );
      },
    );
  }
}
