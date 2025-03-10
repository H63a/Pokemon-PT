import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_pt_yeag/common/type.dart';
import 'package:pokemon_pt_yeag/data/models/pokemon.dart';
import 'package:pokemon_pt_yeag/ui/widgets/state_bar.dart';
import 'package:pokemon_pt_yeag/ui/widgets/info_column.dart';
import 'package:pokemon_pt_yeag/data/providers/pokedex.dart';

class PokemonScreen extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonScreen({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final speciesData =
        Provider.of<PokedexProvider>(context).pokemonSpeciesData[pokemon.name];
    final typeColor = getTypeColor(pokemon.types.first.type.name);
    final statNames = ['HP', 'ATK', 'DEF', 'SATK', 'SDEF', 'SPD'];

    return Scaffold(
      backgroundColor: typeColor,
      body: Stack(
        children: [
          //Pokeball background
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

          // White card
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Pokemon types
                    Wrap(
                      spacing: 12.0,
                      children: pokemon.types.map((type) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: getTypeColor(type.type.name),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            type.type.name.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // About Section ----------
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: typeColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InfoColumn(
                          icon: Icons.fitness_center,
                          label: "Weight",
                          value: "${pokemon.weight / 10} kg",
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.grey.shade300,
                        ),
                        InfoColumn(
                          icon: Icons.height,
                          label: "Height",
                          value: "${pokemon.height / 10} m",
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.grey.shade300,
                        ),
                        InfoColumn(
                          label: "Abilities",
                          value: pokemon.abilities
                              .map((e) => e.ability.name)
                              .toList(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Description
                    if (speciesData != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Text(
                              speciesData.description
                                  .replaceAll("\n", " ") // Delete
                                  .trim(),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Base Stats Section ----------------
                    Text(
                      'Base Stats',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: typeColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Pokemon Stats
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: statNames.map((name) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  name,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: typeColor,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 1,
                          height: 150,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 7,
                          child: Column(
                            children: List.generate(statNames.length, (index) {
                              return StatBar(
                                statName: statNames[index],
                                value: pokemon.stats[index].baseStat,
                                color: typeColor,
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Pokemon image between the app bar and the card-----
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Image.network(
              pokemon.sprites.other!.showdown.frontDefault,
              height: 250,
              fit: BoxFit.contain,
            ),
          ),

          // AppBar ------------------
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    "#${pokemon.id.toString().padLeft(3, '0')}",
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
