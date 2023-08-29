import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/repo_provider.dart';
import '../widgets/repo_app_bar.dart';
import '../widgets/repo_card.dart';

class FavoritesRepoScreen extends StatelessWidget {
  const FavoritesRepoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RepoAppBar(
        isChildScreen: true,
        title: 'Favorite repos list',
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: Selector<RepoProvider, List<String>>(
              shouldRebuild: (previous, next) => true,
              selector: (_, selector) => selector.favoritesRepos,
              builder: (context, favorites, child) {
                if (favorites.isEmpty) {
                  return Center(
                    child: Text(
                      'You have no favorites.\nClick on star while searching to add first favorite',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).unselectedWidgetColor,
                          ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final repo = favorites[index];
                    return RepoCard(
                      isFavorite: true,
                      reposName: repo,
                      onPressed: () => context
                          .read<RepoProvider>()
                          .toggleFavoriteStateForRepo(repo),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
