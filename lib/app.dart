import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/di/injection.dart';
import 'package:test_app/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:test_app/features/articles/presentation/bloc/articles_event.dart';
import 'package:test_app/features/articles/presentation/pages/articles_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Articles',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1C1C1E),
          surface: const Color(0xFFF3F4F6),
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF3F4F6),
          foregroundColor: Color(0xFF111111),
          elevation: 0,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF1C1C1E),
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      home: BlocProvider(
        create: (_) => sl<ArticlesBloc>()..add(const ArticlesStarted()),
        child: const ArticlesPage(),
      ),
    );
  }
}
