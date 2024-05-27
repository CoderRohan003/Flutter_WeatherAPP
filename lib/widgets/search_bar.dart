import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const SearchBar({
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
      ),
      onSubmitted: onSubmitted,
    );
  }
}
