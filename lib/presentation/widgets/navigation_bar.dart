import 'package:flutter/material.dart';

import '../screens/favorites_repo.dart';
import 'repo_icon_button.dart';

class RepoNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isChildScreen;

  const RepoNavigationBar({
    super.key,
    required this.title,
    this.isChildScreen = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 6);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      shadowColor: Colors.grey[200]!.withOpacity(0.4),
      iconTheme: const IconThemeData(size: 24),
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leadingWidth: 90,
      leading: isChildScreen
          ? RepoIconButton(
              iconAssetName: 'assets/icons/Left.svg',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      actions: [
        if (!isChildScreen)
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: RepoIconButton(
              iconAssetName: 'assets/icons/Favorite_active.svg',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoritesRepoScreen()));
              },
            ),
          ),
      ],
    );
  }
}
