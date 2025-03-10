class PokemonSpecies {
  final String description;

  PokemonSpecies({
    required this.description,
  });

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) {
    return PokemonSpecies(
      description: (json['flavor_text_entries'] as List).firstWhere(
          (entry) => entry['language']['name'] == 'en')['flavor_text'],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
      };
}
