import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';

class DailyQuotePage extends StatefulWidget {
  const DailyQuotePage({super.key});

  @override
  State<DailyQuotePage> createState() => _DailyQuotePageState();
}

class _DailyQuotePageState extends State<DailyQuotePage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date = "${weekday[now.weekday]}, ${months[now.month]} ${now.day}";

    return FutureBuilder<Map?>(
      future: getTodayMessage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
        return Container(
          decoration: AppTheme.backgroundGradient,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Header
                    SizedBox(height: 100),
                    Text(
                      date,
                      style: TextStyle(
                        color: AppTheme.mainText.withAlpha(200),
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: padding),
                    GradientText(
                      text: "Daily Spark",
                      gradient: AppTheme.textGradient,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    QuoteBlock(
                      quote: snapshot.data?['quote'],
                      author: snapshot.data?['author'],
                    ),
                    SizedBox(height: 50),
                    MessageBlock(message: snapshot.data?['message']),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTapUp: (TapUpDetails details) async {
                        await quoteBox.put(
                          'key_$date',
                          Quote(
                            quote: snapshot.data?['quote'],
                            author: snapshot.data?['author'],
                            date: date,
                          ),
                        );
                        // setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppTheme.authorText, Colors.white],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GradientText(
                          gradient: LinearGradient(
                            colors: AppTheme.backgroundColors,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          text: "Save Today's Quote",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
