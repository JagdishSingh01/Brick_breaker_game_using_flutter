import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final brickX;
  final brickY;
  final brickWidth;
  final brickHeight;
  final bool brickBroken;
  const MyBrick({
    super.key,
    this.brickX,
    this.brickY,
    this.brickWidth,
    this.brickHeight,
    required this.brickBroken,
  });

  @override
  Widget build(BuildContext context) {
    return brickBroken
    ? Container()
    : Container(
      alignment: Alignment(brickX, brickY),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: MediaQuery.of(context).size.height * brickHeight / 2,
          width: MediaQuery.of(context).size.width * brickWidth / 2,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
