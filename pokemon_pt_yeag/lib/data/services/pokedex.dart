// Pokédex service
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_pt_yeag/common/api_routes.dart';
import 'package:pokemon_pt_yeag/data/models/pokedex.dart';
import 'package:pokemon_pt_yeag/data/models/pokemon.dart';
import 'package:pokemon_pt_yeag/data/models/species.dart';

class PokedexService extends ChangeNotifier {
  // Get Pokedex
  Future<List<Result>> getPokedexList() async {
    final response = await http.get(
      Uri.parse(ApiRoutes.pokedex),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Result.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  // Get Pokemon data
  Future<Pokemon> getPokemonData(String url) async {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print("Data: ${Pokemon.fromJson(data)}");
      return Pokemon.fromJson(data);
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  // Get Pokemon species data
  Future<PokemonSpecies> getPokemonSpeciesData(String url) async {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return PokemonSpecies.fromJson(data);
    } else {
      throw Exception('Failed to load Pokémon species');
    }
  }
}
