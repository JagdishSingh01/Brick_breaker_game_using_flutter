import 'dart:async';

import 'package:brick_breaker_game/ball.dart';
import 'package:brick_breaker_game/coverscreen.dart';
import 'package:brick_breaker_game/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ball variables
  double ballX = 0;
  double ballY = 0;

  //player variables
  double playerX = 0;
  double playerWidth = 0.3;

  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        moveLeft();
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        moveRight();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  void moveLeft() {
    setState(() {
      if(!(playerX - 0.2 < -1)){
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if(!(playerX + 0.2 > 1)){
        playerX += 0.2;
      }
    });
  }

  //game setting
  bool hasGameStarted = false;

  //start game
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      //move ball
      setState(() {
        ballY += 0.01;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                //tap to play
                Coverscreen(hasGameStarted: hasGameStarted),

                //ball
                MyBall(ballX: ballX, ballY: ballY),

                //Player
                MyPlayer(playerX: playerX, playerWidth: playerWidth),

                // Container(
                //   alignment: Alignment(playerX, 0.9),
                //   child: Container(
                //     color: Colors.red,
                //     width: 3,
                //     height: 15,
                //   ),
                // ),
                // Container(
                //   alignment: Alignment(playerX+playerWidth, 0.9),
                //   child: Container(
                //     color: Colors.green,
                //     width: 3,
                //     height: 15,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
