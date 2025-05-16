import 'dart:async';

import 'package:brick_breaker_game/ball.dart';
import 'package:brick_breaker_game/brick.dart';
import 'package:brick_breaker_game/cover_screen.dart';
import 'package:brick_breaker_game/gameover_screen.dart';
import 'package:brick_breaker_game/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXincrements = 0.007;
  double ballYincrements = 0.007;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  //brick variables
  //equation: 2*wallGap + n*brickWidth + (n-1)*brickGap = 2
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.4; //out of 2
  static double brickHeight = 0.07; //out of 2
  static double brickGap = 0.13;
  static int numberOfBricksInRow = 4;
  static double wallGap =
      0.5 *
      (2 -
          numberOfBricksInRow * brickWidth +
          (numberOfBricksInRow - 1) * brickGap);
  bool brickBroken = false;

  List MyBricks = [
    //[x, y, broken = true/false]
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
  ];

  //player variables
  double playerX = -0.2;
  double playerWidth = 0.4; //out of 2

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
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  //game setting
  bool hasGameStarted = false;
  bool isGameOver = false;

  //start game
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      //update ball direction
      updateDirection();

      //move ball
      moveBall();

      //check if player is dead
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }

      //check if brick is hit
      checkForBrokenBricks();
    });
  }

  void checkForBrokenBricks() {
    //check for when ball hits the brick
    for (int i = 0; i < MyBricks.length; i++){
      if (ballX >= MyBricks[i][0] &&
          ballX <= MyBricks[i][0] + brickWidth &&
          ballY <= MyBricks[i][1] + brickHeight &&
          MyBricks[i][2] == false) {
        setState(() {
          MyBricks[i][2] = true;

          //since the ball is broken, update the direction of the ball
          //based on which side of the brick it will hit

          //if ball hits bottom side of brik 
          ballYDirection = direction.DOWN;

          //if ball hits top side of brik 
          ballYDirection = direction.UP;

          //if ball hits left side of brik 
          ballYDirection = direction.LEFT;
          //if ball hits right side of brik 
          ballYDirection = direction.RIGHT ;


        });
      }
    }   
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void moveBall() {
    //move vetically
    setState(() {
      if (ballYDirection == direction.DOWN) {
        ballY += ballXincrements;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballXincrements;
      }
    });

    //move horizontally
    setState(() {
      if (ballXDirection == direction.LEFT) {
        ballX -= ballYincrements;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += ballYincrements;
      }
    });
  }

  //update ball direction
  void updateDirection() {
    setState(() {
      //ball goes up when it hits the player
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = direction.UP;
      }
      //ball goes down when it hits the top of the screen
      else if (ballY <= -1) {
        ballYDirection = direction.DOWN;
      }

      //ball goes left when it hits right wall
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      }
      //ball goes right when it hits left wall
      else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
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

                //game over screen
                GameoverScreen(isGameOver: isGameOver),

                //ball
                MyBall(ballX: ballX, ballY: ballY),

                //Player
                MyPlayer(playerX: playerX, playerWidth: playerWidth),

                //bricks
                MyBrick(
                  brickX: MyBricks[0][0],
                  brickY: MyBricks[0][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: MyBricks[0][2],
                ),
                MyBrick(
                  brickX: MyBricks[1][0],
                  brickY: MyBricks[1][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: MyBricks[1][2],
                ),
                MyBrick(
                  brickX: MyBricks[2][0],
                  brickY: MyBricks[2][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: MyBricks[2][2],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
