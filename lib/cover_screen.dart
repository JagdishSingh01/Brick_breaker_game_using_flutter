import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Coverscreen extends StatelessWidget {
  final bool hasGameStarted;
  final bool isGameOver;

  //font
  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.deepPurple[600], fontSize: 22),
  );

  const Coverscreen({super.key, required this.hasGameStarted, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
          alignment: Alignment(0, -0.5),
          child: Text( isGameOver? '':
            'BRICK BREAKER',
            style: gameFont.copyWith(color: Colors.deepPurple[200]),
          ),
        )
        : Stack(
          children: [
            Container(
              alignment: Alignment(0, -0.5),
              child: Text('BRICK BREAKER', style: gameFont),
            ),
            Container(
              alignment: Alignment(0, -0.2),
              child: Text(
                'Tap to play',
                style: TextStyle(color: Colors.deepPurple[400]),
              ),
            ),
          ],
        );
  }
}
