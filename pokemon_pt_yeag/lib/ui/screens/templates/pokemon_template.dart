import 'package:flutter/material.dart';
import 'package:pokemon_pt_yeag/common/format_text.dart';
// Pokemon details screen template

class PokemonTemplate extends StatelessWidget {
  final Color color;
  final String name;
  final String id;
  final Widget content;
  final String pokeImg;
  const PokemonTemplate({
    super.key,
    required this.color,
    required this.name,
    required this.id,
    required this.content,
    required this.pokeImg,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Stack(
        children: [
          //Pokeball background ----------------------
          Positioned(
            top: 40,
            right: 8,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/pokeball.png',
                fit: BoxFit.contain,
                height: 250,
              ),
            ),
          ),

          // ----- White Card -------------------------
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            bottom: MediaQuery.of(context).size.height * 0.001,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: SingleChildScrollView(
                //Card content
                child: content,
              ),
            ),
          ),

          // ----- Pokemon image -------------------------
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Image.network(
              pokeImg,
              height: 250,
              fit: BoxFit.contain,
            ),
          ),

          // ----- AppBar ---------------------------------
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              // Title
              title: Text(
                capitalize(name),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              // Backwards
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    "#${formatId(id)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
