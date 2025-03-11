import 'package:flutter/material.dart';
import 'package:pokemon_pt_yeag/data/models/pokedex.dart';
import 'package:pokemon_pt_yeag/data/models/pokemon.dart';
import 'package:pokemon_pt_yeag/data/models/species.dart';
import 'package:pokemon_pt_yeag/data/services/pokedex.dart';

class PokedexProvider with ChangeNotifier {
  String? _errorMessage;
  bool _isLoading = false;
  String _searchQuery = '';
  List<Result> _pokedex = [];
  bool _isSortedByName = false;
  final PokedexService service;
  final Map<String, Pokemon> _pokemonData = {};
  final Map<String, PokemonSpecies> _pokemonSpeciesData = {};

  PokedexProvider(this.service);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSortedByName => _isSortedByName;
  Map<String, Pokemon> get pokemonData => _pokemonData;
  Map<String, PokemonSpecies> get pokemonSpeciesData => _pokemonSpeciesData;
  // Get Pokemon List
  List<Result> get pokedex {
    List<Result> sortedPokedex = List.from(_pokedex);
    if (_isSortedByName) {
      sortedPokedex.sort((a, b) => a.name.compareTo(b.name));
    } else {
      sortedPokedex.sort((a, b) =>
          _pokemonData[a.name]!.id.compareTo(_pokemonData[b.name]!.id));
    }
    return _searchQuery.isEmpty
        ? sortedPokedex
        : sortedPokedex
            .where((result) => result.name.contains(_searchQuery.toLowerCase()))
            .toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleSortOrder() {
    _isSortedByName = !_isSortedByName;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPokedex() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pokedex = await service.getPokedexList();
      await fetchAllPokemonData();
    } catch (e) {
      //Manage errors
      _setError('Failed to load Pokémon list: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllPokemonData() async {
    for (var result in _pokedex) {
      await fetchPokemonData(result.url);
    }
  }

  Future<void> fetchPokemonData(String url) async {
    try {
      final pokemon = await service.getPokemonData(url);
      _pokemonData[pokemon.name] = pokemon;

      final speciesUrl = pokemon.species.url;
      final speciesData = await service.getPokemonSpeciesData(speciesUrl);
      _pokemonSpeciesData[pokemon.name] = speciesData;

      notifyListeners();
    } catch (e) {
      //Manage errors
      _setError('Error loading Pokémon data: $e');
    }
  }
}
