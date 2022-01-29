import 'package:flutter/material.dart';

class SubmenuTile extends StatelessWidget {
  const SubmenuTile({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        const Icon(Icons.arrow_forward_ios_sharp)
      ],
    );
  }
}
