import 'package:flutter/material.dart';
import 'package:pokemon_pt_yeag/common/constants.dart';

class PokemonCard extends StatelessWidget {
  final String name;
  final int id;
  final String? imgUrl;
  const PokemonCard({
    super.key,
    required this.name,
    required this.id,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    String formatId(int id) {
      return id.toString().padLeft(3, '0');
    }

    String capitalize(String name) {
      if (name.isEmpty) return name;
      return name[0].toUpperCase() + name.substring(1);
    }

    return Padding(
      padding: const EdgeInsets.all(1),
      child: Card(
        color: Colors.white,
        elevation: 6,
        shadowColor: AppConstants.shadowColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        // child: ListTile(
        //   leading: imgUrl != null
        //       ? Image.network(imgUrl!)
        //       : const Icon(Icons.catching_pokemon, size: 40),
        //   title: Text(capitalize(name)),
        //   trailing: Text(id != 0 ? "#${formatId(id).toString()}" : '#000'),
        // ),
        child: Stack(
          children: [
            // ID
            Positioned(
              top: 8,
              right: 8,
              child: Text(
                id != 0 ? "#${formatId(id).toString()}" : '#000',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      //Background
                      Container(
                        height: 60,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: AppConstants.shadowColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),

                      // Pokemon image
                      Positioned(
                        bottom: 16,
                        child: imgUrl != null
                            ? Image.network(
                                imgUrl!,
                                height: 100,
                                fit: BoxFit.contain,
                              )
                            : const Icon(Icons.catching_pokemon, size: 40),
                      ),

                      // Pokemon name
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Text(
                          capitalize(name),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
