import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Motivue/library.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<int, String> months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };
  Map<int, String> weekday = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday",
  };
  @override
  Widget build(BuildContext context) {
    LayoutConfig.init(context);

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

Future<Map?> getTodayMessage() async {
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final snapshot = await FirebaseFirestore.instance
      .collection('daily_messages')
      .doc(today)
      .get();
  if (snapshot.exists) {
    return snapshot.data();
  }
  return {
    "message": "No message for today yet :(",
    "quote": "No quote for today yet :(",
    "author": "Coming soon",
  };
}
