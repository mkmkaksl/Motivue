import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';

class FallingCircle extends StatefulWidget {
  const FallingCircle({super.key});

  @override
  State<FallingCircle> createState() => _FallingCircleState();
}

class _FallingCircleState extends State<FallingCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController animCont;
  late final Animation<double> fallingAnim;

  double size = 5;
  double x = 0;
  double y = 0;
  int alpha = 0;
  int buffer = 50;

  @override
  void initState() {
    super.initState();
    animCont = AnimationController(
      duration: Duration(milliseconds: 10000),
      vsync: this,
    );

    Random random = Random();
    y = -(size * 2) - (random.nextDouble() * buffer);
    x = random.nextDouble() * screenW;
    alpha = random.nextInt(100);
    size = random.nextDouble() * 5;

    fallingAnim = Tween(
      begin: screenH + size,
      end: y,
    ).animate(CurvedAnimation(parent: animCont, curve: Curves.linear));

    animCont.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animCont,
      builder: (builder, child) {
        return CustomPaint(
          painter: Circle(
            x: x,
            y: fallingAnim.value,
            circleSize: size,
            alpha: alpha,
          ),
        );
      },
    );
  }
}
