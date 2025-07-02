import 'package:Motivue/library.dart';
import 'package:flutter/material.dart';

class Circle extends CustomPainter {
  double x;
  double y;
  double circleSize;
  int alpha;

  Circle({
    required this.x,
    required this.y,
    required this.circleSize,
    this.alpha = 255,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = bgCircleColor.withAlpha(alpha)
      ..style = PaintingStyle.fill;

    final center = Offset(x, y);

    // Uncomment for glow effect on circle
    // Path oval = Path()
    //   ..addOval(Rect.fromCircle(center: center, radius: circleSize + 1));
    // Paint shadowPaint = Paint()
    //   ..color = Colors.white.withAlpha(200)
    //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3);

    // canvas.drawPath(oval, shadowPaint);

    canvas.drawCircle(center, circleSize, paint);
  }

  @override
  bool shouldRepaint(covariant Circle oldCircle) {
    return oldCircle.y != y;
  }
}
