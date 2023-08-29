import 'package:flutter/material.dart';
import 'package:repo_search_app/presentation/widgets/repo_input_decor.dart';
import 'package:repo_search_app/provider/repo_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/navigation_bar.dart';
import '../widgets/repo_card.dart';

class RepoSearchScreen extends StatelessWidget {
  const RepoSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final foundRepos = context.read<RepoProvider>().repos;
    final isLoading = context
        .select<RepoProvider, bool>((provider) => provider.isLoadingRepos);
    final controller = context.select<RepoProvider, TextEditingController>(
        (provider) => provider.searchController);
    final titleText =
        context.select<RepoProvider, String>((provider) => provider.titleText);
    final bodyText =
        context.select<RepoProvider, String?>((provider) => provider.bodyText);

    return Scaffold(
      appBar: const RepoNavigationBar(title: 'Github repos list'),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    return RepoInputField(
                        controller: controller,
                        onPressed: () async {
                          await context
                              .read<RepoProvider>()
                              .searchRepositories();
                        });
                  }),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: !isLoading,
                    child: Text(titleText,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                )),
                  ),
                ],
              )),
          if (isLoading)
            const CircularProgressIndicator()
          else if (bodyText != null)
            Expanded(
              child: Center(
                child: Text(bodyText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).unselectedWidgetColor,
                        )),
              ),
            )
          else
            Expanded(
              child: Selector<RepoProvider, List<String>>(
                  shouldRebuild: (previous, next) => true,
                  selector: (_, selector) => selector.favoritesRepos,
                  builder: (context, favorites, child) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: foundRepos.length,
                      itemBuilder: (context, index) {
                        return RepoCard(
                          isFavorite: favorites.contains(foundRepos[index]),
                          reposName: foundRepos[index],
                          onPressed: () => context
                              .read<RepoProvider>()
                              .updateFavoritesAndNotify(foundRepos[index]),
                        );
                      },
                    );
                  }),
            ),
        ],
      ),
    );
  }
}
