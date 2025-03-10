import 'package:flutter/material.dart';

class InfoColumn extends StatelessWidget {
  final IconData? icon;
  final String label;
  final dynamic value;
  const InfoColumn({
    super.key,
    this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Icon
            if (icon != null)
              Icon(
                icon,
                size: 22,
                color: Colors.grey.shade600,
              ),
            const SizedBox(width: 4),

            // Column text
            if (value is List<String>)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: (value as List<String>)
                    .map((e) => Text(
                          e,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black45),
                        ))
                    .toList(),
              )
            else
              // Normal text
              Text(
                value.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.black45),
              ),
          ],
        ),
        const SizedBox(height: 2),

        // Title
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
