import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';

class QuoteBlock extends StatefulWidget {
  final String quote;
  final String author;
  const QuoteBlock({super.key, required this.quote, required this.author});

  @override
  State<QuoteBlock> createState() => _QuoteBlockState();
}

class _QuoteBlockState extends State<QuoteBlock> {
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
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          Text(
            widget.quote,
            style: TextStyle(
              color: AppTheme.mainText,
              fontSize: 15,
              fontStyle: FontStyle.italic,
              shadows: [Shadow(color: AppTheme.mainText, blurRadius: 10)],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: padding),
          GradientText(
            gradient: AppTheme.textGradient,
            text: "- ${widget.author}",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
