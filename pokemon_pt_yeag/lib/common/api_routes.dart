class ApiRoutes {
  ApiRoutes._();

  // Max pokemon limit
  static const int maxLimit = 45;

  static const String pokedex =
      'https://pokeapi.co/api/v2/pokemon?limit=$maxLimit';
}
