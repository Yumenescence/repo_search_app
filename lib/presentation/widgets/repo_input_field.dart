import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RepoInputField extends StatefulWidget {
  final String initialValue;
  final Function(String) onSubmit;
  const RepoInputField(
      {required this.onSubmit, required this.initialValue, super.key});

  @override
  State<RepoInputField> createState() => _RepoInputFieldState();
}

class _RepoInputFieldState extends State<RepoInputField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (_) {
        setState(() {
          // Trigger to rebuild component and show clear icon
        });
      },
      onSubmitted: (value) => widget.onSubmit(value),
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Search',
        suffixIcon: _searchController.text.isEmpty
            ? null
            : IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/Close.svg',
                  height: 24.0,
                ),
                onPressed: () {
                  _searchController.clear();
                  widget.onSubmit("");
                },
              ),
        prefixIcon: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/Search.svg',
            height: 24.0,
          ),
          onPressed: () => {
            // Do nothing, wrapped in button just to not overcomplicate styles
          },
        ),
      ),
    );
  }
}
