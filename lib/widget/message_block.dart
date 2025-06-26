import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';

class MessageBlock extends StatefulWidget {
  final String message;
  const MessageBlock({super.key, required this.message});

  @override
  State<MessageBlock> createState() => _MessageBlockState();
}

class _MessageBlockState extends State<MessageBlock> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenW * (3 / 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.mainText, width: 1),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: AppTheme.backgroundColors),
      ),
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Today's Message:",
            style: TextStyle(color: AppTheme.authorText, fontSize: 18),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: padding),
          Text(
            widget.message,
            style: TextStyle(color: AppTheme.mainText, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
