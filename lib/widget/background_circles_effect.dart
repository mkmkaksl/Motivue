import 'dart:async';
import 'package:Motivue/library.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class BackgroundCirclesEffect extends StatefulWidget {
  const BackgroundCirclesEffect({super.key});

  @override
  State<BackgroundCirclesEffect> createState() =>
      _BackgroundCirclesEffectState();
}

class _BackgroundCirclesEffectState extends State<BackgroundCirclesEffect> {
  Random random = Random();
  final List<CircleData> fallingCircles = [];
  late Timer? circleSpawnTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      startCreatingCircles();
    });
  }

  void startCreatingCircles() {
    circleSpawnTimer = Timer.periodic(Duration(milliseconds: 350), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      for (int i = 0; i < 2; i++) {
        final key = UniqueKey();
        final widget = FallingCircle(key: key);
        setState(() {
          fallingCircles.add(CircleData(widget));
        });

        Future.delayed(Duration(seconds: 20), () {
          if (!mounted) return;
          setState(() {
            fallingCircles.removeWhere((circle) => circle.key == key);
          });
        });
      }
    });
  }

  @override
  void dispose() {
    circleSpawnTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: fallingCircles.map((circle) => circle.widget).toList(),
    );
  }
}

class CircleData {
  final Widget widget;
  final UniqueKey key;

  CircleData(this.widget) : key = widget.key as UniqueKey;
}
