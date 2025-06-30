import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';
import 'package:share_plus/share_plus.dart';

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
                    SizedBox(height: 30),
                    DailyDisplayWidget(
                      quote: snapshot.data?["quote"],
                      author: snapshot.data?['author'],
                      message: snapshot.data?['message'],
                    ),

                    // Save Today's Quote
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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

                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () async {
                              String message =
                                  "${snapshot.data?["message"]}\nHere's the quote of the day:\n${snapshot.data?["quote"]}\n--${snapshot.data?["author"]}";
                              await SharePlus.instance.share(
                                ShareParams(text: message),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppTheme.authorText.withAlpha(50),
                                border: Border.all(
                                  color: AppTheme.authorText.withAlpha(60),
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.ios_share,
                                color: AppTheme.authorText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
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
