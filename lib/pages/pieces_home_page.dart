import 'package:flutter/material.dart';

class PiecesHomePage extends StatelessWidget {
  const PiecesHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Decoration with an image background
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/Piano.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
