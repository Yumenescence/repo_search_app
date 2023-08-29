import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:repo_search_app/presentation/screens/loading.dart';
import 'package:repo_search_app/presentation/screens/repo_search.dart';
import 'package:repo_search_app/provider/repo_provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider(
        create: (context) {
          final state = RepoProvider();
          state.initialize();
          return state;
        },
        child: const RepoSearchApp()),
  );
}

class RepoSearchApp extends StatelessWidget {
  const RepoSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context
        .select<RepoProvider, bool>((provider) => provider.isLoadingHistory);
    return MaterialApp(
      title: 'GitHub Repo Search',
      theme: ThemeData(
        primaryColor: const Color(0xFF1362F5),
        unselectedWidgetColor: const Color(0xFFBFBFBF),
        secondaryHeaderColor: const Color(0xFFF2F2F2),
        hoverColor: const Color(0xFFE5EDFF),
        highlightColor: const Color(0xFFF9F9F9),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Color(0xFF211814),
            fontSize: 16,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF211814),
            fontSize: 14,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w400,
          ),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF9F9F9),
            foregroundColor: Color(0xFF211814)),
      ),
      home: isLoading ? const LoadingScreen() : const RepoSearchScreen(),
    );
  }
}
