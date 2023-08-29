import 'package:provider/provider.dart';

import 'presentation/screens/favorites_repo.dart';
import 'presentation/screens/loading.dart';
import 'presentation/screens/repo_search.dart';
import 'provider/repo_provider.dart';

final routes = {
  '/': (context) {
    // TODO: Find better way to redirect without context from provider
    // maybe use navigatorKey or some library like GetIt
    return Selector<RepoProvider, bool>(
      selector: (_, provider) => provider.isInitialized,
      builder: (context, isInitialized, child) {
        if (isInitialized) {
          return const LoadingScreen();
        }
        return const RepoSearchScreen();
      },
    );
  },
  '/favorites': (context) => const FavoritesRepoScreen(),
};
