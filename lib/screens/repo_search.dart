import 'package:flutter/material.dart';
import 'package:repo_search_app/provider/repo_provider.dart';
import 'package:provider/provider.dart';

class RepoSearchScreen extends StatelessWidget {
  const RepoSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final state = RepoProvider();
        state.initialize();
        return state;
      },
      child: const _Screen(),
    );
  }
}

class _Screen extends StatelessWidget {
  const _Screen();

  @override
  Widget build(BuildContext context) {
    final repos = context.read<RepoProvider>().repos;
    final isLoading =
        context.select<RepoProvider, bool>((provider) => provider.isLoading);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repo Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: context.select<RepoProvider, TextEditingController>(
                  (provider) => provider.searchController),
              decoration: InputDecoration(
                labelText: 'Search Repositories',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    await context.read<RepoProvider>().searchRepositories();
                  },
                ),
              ),
            ),
          ),
          if (isLoading)
            const CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(repos[index].name),
                    trailing: Selector<RepoProvider, Set<String>>(
                      shouldRebuild: (previous, next) => true,
                      selector: (_, selector) => selector.favorites,
                      builder: (context, favorites, child) {
                        return IconButton(
                            icon: Icon(Icons.heart_broken,
                                color: favorites.contains(repos[index].name)
                                    ? Colors.red
                                    : Colors.green),
                            onPressed: () => context
                                .read<RepoProvider>()
                                .updateFavoritesAndNotify(repos[index]));
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
