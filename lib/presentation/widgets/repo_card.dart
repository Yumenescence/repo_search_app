import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RepoCard extends StatelessWidget {
  final String reposName;
  final VoidCallback onPressed;
  final bool isFavorite;

  const RepoCard({
    super.key,
    required this.reposName,
    required this.onPressed,
    required this.isFavorite,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          reposName,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/Favorite_active.svg',
            colorFilter: ColorFilter.mode(
              isFavorite
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).unselectedWidgetColor,
              BlendMode.srcIn,
            ),
            height: 24.0,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
