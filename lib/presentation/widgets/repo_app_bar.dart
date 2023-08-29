import 'package:flutter/material.dart';
import 'repo_nav_button.dart';

class RepoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isChildScreen;
  final bool showFavoritesButton;

  const RepoAppBar({
    super.key,
    required this.title,
    this.isChildScreen = false,
    this.showFavoritesButton = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 6);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leadingWidth: 90,
      leading: isChildScreen
          ? RepoNavButton(
              iconAssetName: 'assets/icons/Left.svg',
              onPressed: () => Navigator.pop(context),
            )
          : null,
      actions: [
        if (showFavoritesButton)
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: RepoNavButton(
              iconAssetName: 'assets/icons/Favorite_active.svg',
              onPressed: () {
                Navigator.pushNamed(context, '/favorites');
              },
            ),
          ),
      ],
    );
  }
}
