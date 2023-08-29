import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RepoIconButton extends StatelessWidget {
  const RepoIconButton({
    super.key,
    required this.iconAssetName,
    required this.onPressed,
    this.isFavorite = false,
  });

  final String iconAssetName;
  final VoidCallback onPressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: const BoxConstraints.tightFor(width: 44.0, height: 44.0),
        child: IconButton(
          constraints: const BoxConstraints(),
          icon: SvgPicture.asset(
            iconAssetName,
            height: 24.0,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
