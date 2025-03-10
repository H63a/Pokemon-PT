import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_pt_yeag/data/providers/pokedex.dart';
import 'package:pokemon_pt_yeag/ui/screens/app/home.dart';
import 'package:pokemon_pt_yeag/data/services/pokedex.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Services
        ChangeNotifierProvider(create: (_) => PokedexService()),
        //Providers
        ChangeNotifierProvider(
            create: (_) => PokedexProvider(PokedexService())),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
