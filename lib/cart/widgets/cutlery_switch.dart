import 'package:flutter/material.dart';
import 'package:o_kay_customer/constants/colors.dart';

class CutlerySwitch extends StatelessWidget {
  final bool isCutlery;
  final Function(bool) onChanged;

  const CutlerySwitch(
      {super.key, required this.isCutlery, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.restaurant_outlined,
                  color: Color.fromARGB(255, 16, 2, 214),
                ),
                const SizedBox(width: 10),
                Text(
                  'Cutlery',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            Switch(
              value: isCutlery,
              activeTrackColor: Color.fromARGB(255, 16, 2, 214),
              activeColor: Colors.white,
              onChanged: onChanged,
            )
          ],
        ),
        Text(
          isCutlery
              ? 'The restaurant will provide cutlery, if available.'
              : 'We won\'t bring cutlery. Thanks for helping us reduce waste.',
          style: TextStyle(color: Colors.grey[600]),
        )
      ],
    );
  }
}
