import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 300,
      child: Center(
        child: Text(message, style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
