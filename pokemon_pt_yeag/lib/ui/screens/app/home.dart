import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_pt_yeag/common/constants.dart';
import 'package:pokemon_pt_yeag/ui/screens/app/pokemon.dart';
import 'package:pokemon_pt_yeag/ui/widgets/search_bar.dart';
import 'package:pokemon_pt_yeag/data/providers/pokedex.dart';
import 'package:pokemon_pt_yeag/ui/widgets/pokemon_card.dart';
import 'package:pokemon_pt_yeag/ui/screens/templates/app_template.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<PokedexProvider>(context, listen: false).fetchPokedex();
      });
    }
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final provider = Provider.of<PokedexProvider>(context);

    return AppTemplate(
      searchBar: AppSearchBar(focusNode: _searchFocusNode),
      appBarActions: [
        IconButton(
          color: Colors.white,
          onPressed: () {
            provider.toggleSortOrder();
          },
          icon: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              provider.isSortedByName ? Icons.abc : Icons.grid_3x3,
              color: AppConstants.identity,
              size: 26,
            ),
          ),
        ),
      ],
      content: Column(
        children: [
          Expanded(
            child: Consumer<PokedexProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.pokedex.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Pokémon found',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(6),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Columns amount
                    childAspectRatio: 1,
                  ),
                  itemCount: provider.pokedex.length,
                  itemBuilder: (context, index) {
                    final result = provider.pokedex[index];
                    final pokemon = provider.pokemonData[result.name];

                    return InkWell(
                      onTap: () {
                        //Pokemons details screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PokemonScreen(pokemon: pokemon!),
                          ),
                        ).then((_) {
                          // Remove focus from the search bar when returning
                          _searchFocusNode.unfocus();
                        });
                      },
                      child: PokemonCard(
                        name: result.name,
                        id: pokemon?.id ?? 0,
                        imgUrl: pokemon?.sprites.frontDefault,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
