import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:repo_search_app/provider/repo_provider.dart';
import 'package:repo_search_app/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/theme/app_theme.dart';
import 'repositories/local_data_store.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider(
      create: (context) {
        final state = RepoProvider(
          localDataStore: LocalDataStore(
            SharedPreferences.getInstance(),
          ),
        );
        state.initialize();
        return state;
      },
      child: const RepoSearchApp(),
    ),
  );
}

class RepoSearchApp extends StatelessWidget {
  const RepoSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repo Search',
      theme: appTheme,
      initialRoute: '/',
      routes: routes,
    );
  }
}
