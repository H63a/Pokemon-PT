import 'package:flutter/material.dart';
import 'package:pokemon_pt_yeag/common/constants.dart';

class AppTemplate extends StatelessWidget {
  final Widget content;
  final Widget searchBar;
  final List<Widget>? appBarActions;
  const AppTemplate({
    super.key,
    required this.content,
    required this.searchBar,
    this.appBarActions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.identity,
      appBar: AppBar(
        backgroundColor: AppConstants.identity,
        leading: const Icon(
          Icons.catching_pokemon,
          color: Colors.white,
          size: 34,
        ),
        title: const Text(
          "Pokédex",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: appBarActions,
      ),
      body: Column(
        children: [
          searchBar,
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                //Screen Content
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
