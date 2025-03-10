import 'package:flutter/material.dart';

class StatBar extends StatelessWidget {
  final String statName;
  final int value;
  final Color color;

  const StatBar({
    super.key,
    required this.statName,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Text(value.toString().padLeft(3, '0')),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              // 255 as MAX value
              value: value / 255.0,
              backgroundColor: color.withOpacity(0.3),
              color: color,
              minHeight: 6,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
