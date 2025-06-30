import 'package:flutter/material.dart';

class SnackBarWidget extends StatefulWidget {
  const SnackBarWidget({super.key});

  @override
  State<SnackBarWidget> createState() => SnackBarWidgetState();
}

class SnackBarWidgetState extends State<SnackBarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return SnackBar(
          content: FadeTransition(
            opacity: opacityAnimation, // Animation controller for fade-out,
            child: const Text("Your message here"),
          ),
          duration: const Duration(
            seconds: 5,
          ), // Set duration for the message to be visible
        );
      },
    );
  }
}
