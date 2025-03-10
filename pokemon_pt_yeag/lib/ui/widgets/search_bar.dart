import 'package:flutter/material.dart';
import 'package:pokemon_pt_yeag/common/constants.dart';
import 'package:pokemon_pt_yeag/data/providers/pokedex.dart';
import 'package:provider/provider.dart';

class AppSearchBar extends StatelessWidget {
  final FocusNode focusNode;
  const AppSearchBar({super.key, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokedexProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: AppConstants.identity,
          ),
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        onChanged: (value) {
          provider.setSearchQuery(value);
        },
      ),
    );
  }
}
