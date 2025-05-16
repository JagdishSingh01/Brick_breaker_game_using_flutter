import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameoverScreen extends StatelessWidget {
  final bool isGameOver;
  final function;

  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.deepPurple[600], fontSize: 22
    )
  );

  const GameoverScreen({super.key, required this.isGameOver, this.function});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
          children: [
            Container(
              alignment: Alignment(0, -0.2),
              child: Text(
                'GAME OVER',
                style: gameFont,
              ),
            ),
            Container(
              alignment: Alignment(0, 0),
              child: GestureDetector(
                onTap: function,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.deepPurple,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
        : Container();
  }
}
