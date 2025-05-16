import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double ballX;
  final double ballY;
  final bool isGameOver;
  final bool hasGameStarted;

  const MyBall({
    super.key,
    required this.ballX,
    required this.ballY,
    required this.isGameOver,
    required this.hasGameStarted,
  });

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment: Alignment(ballX, ballY),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isGameOver ? Colors.deepPurple[300] : Colors.deepPurple,
                shape: BoxShape.circle,
              ),
            ),
          )
        : Container(
            alignment: Alignment(ballX, ballY),
            child: AvatarGlow(
              glowColor: const Color.fromARGB(255, 255, 255, 255), 
              endRadius: 60.0, 
              duration: Duration(seconds: 2), 
              repeat: true, 
              child: Material(
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    ),
                    width: 12,
                    height: 12,
                  ),
                  radius: 7.0,
                ),
              ),
            ),
          );
  }
}