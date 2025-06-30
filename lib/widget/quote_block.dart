import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';

class QuoteBlock extends StatefulWidget {
  final String quote;
  final String author;

  final bool delete;
  final bool add;
  final String date;
  const QuoteBlock({
    super.key,
    required this.quote,
    required this.author,
    this.delete = false,
    this.add = false,
    this.date = "",
  });

  @override
  State<QuoteBlock> createState() => _QuoteBlockState();
}

class _QuoteBlockState extends State<QuoteBlock>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.delete == true && widget.add == true) {
      return ErrorScreen(
        message: "Both delete and add cannot be enabled for quote",
      );
    }
    if ((widget.delete == true || widget.add == true) && widget.date == "") {
      return ErrorScreen(
        message: "Date must be provided for quote block widget",
      );
    }

    return AnimatedBuilder(
      animation: animationController,
      builder: (builder, child) {
        return Container(
          width: screenW * (3 / 4),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.mainText, width: 1),
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: AppTheme.backgroundColors),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    widget.quote,
                    style: TextStyle(
                      color: AppTheme.mainText,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(color: AppTheme.mainText, blurRadius: 10),
                      ],
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
              if (widget.delete)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTapUp: (TapUpDetails details) async {
                      await quoteBox.delete("key_${widget.date}");
                      showSnackBar(
                        context,
                        opacityAnimation,
                        "Quote Removed!",
                        Colors.red,
                        Colors.white,
                      );
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.red.withAlpha(50),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.delete_outline, color: Colors.red),
                    ),
                  ),
                ),
              if (widget.add)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTapUp: (TapUpDetails details) async {
                      await quoteBox.put(
                        "key_${widget.date}",
                        Quote(
                          quote: widget.quote,
                          author: widget.author,
                          date: widget.date,
                        ),
                      );
                      showSnackBar(
                        context,
                        opacityAnimation,
                        "Quote added!",
                        Colors.green,
                        Colors.white,
                      );
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppTheme.authorText.withAlpha(50),
                      ),
                      padding: EdgeInsets.all(3),
                      child: Icon(Icons.add, color: AppTheme.authorText),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
