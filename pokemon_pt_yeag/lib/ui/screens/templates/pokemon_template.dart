import 'package:flutter/material.dart';

class PokemonTemplate extends StatelessWidget {
  final Color color;
  final String name;
  final String id;
  final Widget content;
  const PokemonTemplate({
    super.key,
    required this.color,
    required this.name,
    required this.id,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    String formatId(String id) {
      return id.padLeft(3, '0');
    }

    String capitalize(String name) {
      if (name.isEmpty) return name;
      return name[0].toUpperCase() + name.substring(1);
    }

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 34,
          ),
        ),
        title: Text(
          capitalize(name),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Text(
              "#${formatId(id)}",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(8.0) //                 <--- border radius here
                ),
          ),
          child: content,
        ),
      ),
    );
  }
}
