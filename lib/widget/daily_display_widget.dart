import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';

class DailyDisplayWidget extends StatefulWidget {
  final String quote;
  final String author;
  final String message;

  final String date;
  final bool add;
  const DailyDisplayWidget({
    super.key,
    required this.quote,
    required this.author,
    required this.message,
    this.date = "",
    this.add = false,
  });

  @override
  State<DailyDisplayWidget> createState() => _DailyDisplayWidgetState();
}

class _DailyDisplayWidgetState extends State<DailyDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuoteBlock(
          quote: widget.quote,
          author: widget.author,
          date: widget.date,
          add: widget.add,
        ),
        MessageBlock(message: widget.message),
        SizedBox(height: 30),
      ],
    );
  }
}
