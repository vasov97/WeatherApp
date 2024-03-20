import 'package:flutter/material.dart';

class MaxTempRow extends StatelessWidget {
  const MaxTempRow({
    super.key,
    required this.maxTemp,
  });

  final double maxTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Max: ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Text(
          '$maxTemp°C',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
