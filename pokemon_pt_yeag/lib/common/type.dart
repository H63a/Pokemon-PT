import 'package:flutter/material.dart';
import 'package:pokemon_pt_yeag/common/constants.dart';

// This function is use to get the right color
// depending on the Pokemon type

Color getTypeColor(String typeName) {
  switch (typeName) {
    case 'bug':
      return AppConstants.bug;
    case 'dark':
      return AppConstants.dark;
    case 'dragon':
      return AppConstants.dragon;
    case 'electric':
      return AppConstants.electric;
    case 'fairy':
      return AppConstants.fairy;
    case 'fighting':
      return AppConstants.fighting;
    case 'fire':
      return AppConstants.fire;
    case 'flying':
      return AppConstants.flying;
    case 'ghost':
      return AppConstants.ghost;
    case 'normal':
      return AppConstants.normal;
    case 'grass':
      return AppConstants.grass;
    case 'ground':
      return AppConstants.ground;
    case 'ice':
      return AppConstants.ice;
    case 'poison':
      return AppConstants.poison;
    case 'psychic':
      return AppConstants.psychic;
    case 'rock':
      return AppConstants.rock;
    case 'steel':
      return AppConstants.steel;
    case 'water':
      return AppConstants.water;
    default:
      return Colors.grey;
  }
}
