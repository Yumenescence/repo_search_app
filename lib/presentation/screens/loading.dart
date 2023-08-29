import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Search App',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).highlightColor),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
