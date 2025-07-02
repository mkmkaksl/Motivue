import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withAlpha(50),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.withAlpha(100), width: 1),
      ),
      width: 200,
      height: 300,
      child: Center(
        child: Text(message, style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
