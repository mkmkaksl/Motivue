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
  static const List<Widget> pages = [DailyQuotePage(), SavedQuotesPage()];
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    LayoutConfig.init(context);
    return Scaffold(
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote),
            label: "Saved Quotes",
          ),
        ],
        currentIndex: selectedIndex,
        backgroundColor: AppTheme.authorText,
        onTap: _onItemTapped,
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
