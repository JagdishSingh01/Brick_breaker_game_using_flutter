import 'package:flutter/material.dart';

class Coverscreen extends StatelessWidget {
  final bool hasGameStarted;

  const Coverscreen({super.key, required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
    ? Container()
    : Container(
      alignment: Alignment(0, -0.2),
      child: Text(
        'Tap to play',
        style: TextStyle(color: Colors.deepPurple[400]),
      ),
    );
  }
}
