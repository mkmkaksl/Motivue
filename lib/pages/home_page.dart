import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Motivue/library.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<Widget> pages = [
    DailyQuotePage(),
    SavedQuotesPage(),
    OldMessages(),
  ];
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    LayoutConfig.init(context);
    return Container(
      decoration: AppTheme.backgroundGradient,
      child: Stack(
        children: [
          BackgroundCirclesEffect(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: pages.elementAt(selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.format_quote),
                  label: "Saved Quotes",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.folder_outlined),
                  label: "Old Messages",
                ),
              ],
              currentIndex: selectedIndex,
              backgroundColor: AppTheme.authorText,
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
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

Future<List<Map?>> getOldMessages() async {
  DateTime now = DateTime.now().subtract(Duration(days: 1));

  String year = now.year.toString();
  String month = now.month.toString();
  String day = now.day.toString();

  if (month.length < 2) month = "0$month";
  if (day.length < 2) day = "0$day";

  String today = "$year-$month-$day";

  List<Map?> data = [];

  var snapshot = (await FirebaseFirestore.instance
      .collection("daily_messages")
      .doc(today)
      .get());

  int c = 0;
  while (snapshot.exists && c < 10) {
    data.add(snapshot.data());

    now = now.subtract(Duration(days: 1));

    year = now.year.toString();
    month = now.month.toString();
    day = now.day.toString();

    if (month.length < 2) month = "0$month";
    if (day.length < 2) day = "0$day";

    today = "$year-$month-$day";

    c++;
    if (c >= 30) break;

    snapshot = (await FirebaseFirestore.instance
        .collection("daily_messages")
        .doc(today)
        .get());
  }

  return data;
}

ScaffoldFeatureController showSnackBar(
  BuildContext context,
  Animation<double> opacityAnimation,
  String message,
  Color bgColor,
  Color txtColor,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: FadeTransition(
        opacity: opacityAnimation,
        child: Center(
          child: Text(
            message,
            style: TextStyle(
              color: txtColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: bgColor.withAlpha(200),
      duration: const Duration(seconds: 3),
    ),
  );
}
