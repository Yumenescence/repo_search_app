import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/repo_provider.dart';
import '../widgets/navigation_bar.dart';

class FavoritesRepoScreen extends StatelessWidget {
  const FavoritesRepoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const RepoNavigationBar(
            isChildScreen: true, title: 'Favorite repos list'),
        body: Column(children: [
          Expanded(
            child: Selector<RepoProvider, Set<String>>(
              shouldRebuild: (previous, next) => true,
              selector: (_, selector) => selector.favorites,
              builder: (context, favoritess, child) {
                final favoritesList = favoritess.toList();
                return ListView.builder(
                    itemCount: favoritesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(favoritesList[index]),
                        trailing: IconButton(
                            icon: const Icon(Icons.heart_broken),
                            color: favoritess.contains(favoritesList[index])
                                ? Colors.red
                                : Colors.green,
                            onPressed: () => context
                                .read<RepoProvider>()
                                .updateFavoritesAndNotify(
                                    favoritesList[index])),
                      );
                    });
              },
            ),
          )
        ]));
  }
}
