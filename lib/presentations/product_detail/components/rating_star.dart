import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final double rating;
  final int count;
  const RatingStar(this.rating, this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text(rating.toStringAsFixed(1), style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 4),
        Text(
          '($count)',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
