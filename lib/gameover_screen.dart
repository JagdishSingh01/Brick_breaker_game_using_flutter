import 'package:flutter/material.dart';

class GameoverScreen extends StatelessWidget {
  final bool isGameOver;

  const GameoverScreen({super.key, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Container(
          alignment: Alignment(0, -0.2),
          child: Text(
            'G A M E  O V E R',
            style: TextStyle(color: Colors.deepPurple),
          ),
        )
        : Container();
  }
}
