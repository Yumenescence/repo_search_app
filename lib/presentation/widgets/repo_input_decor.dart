import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RepoInputField extends StatefulWidget {
  final TextEditingController? controller;
  final VoidCallback onPressed;

  const RepoInputField({this.controller, required this.onPressed, super.key});

  @override
  State<RepoInputField> createState() => _RepoInputFieldState();
}

class _RepoInputFieldState extends State<RepoInputField> {
  final FocusNode _textFieldFocus = FocusNode();
  Color _color = const Color(0xFFF2F2F2);

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = const Color(0xFFE5EDFF);
        });
      } else {
        setState(() {
          _color = const Color(0xFFF2F2F2);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _textFieldFocus,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: _color,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        hintText: 'Search',
        prefixIcon: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/Search.svg',
            height: 24.0,
          ),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
