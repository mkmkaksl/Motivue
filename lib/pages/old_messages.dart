import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';

class OldMessages extends StatefulWidget {
  const OldMessages({super.key});

  @override
  State<OldMessages> createState() => _OldMessagesState();
}

class _OldMessagesState extends State<OldMessages> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().subtract(Duration(days: 1));
    String date = "${weekday[now.weekday]}, ${months[now.month]} ${now.day}";

    return FutureBuilder<List<Map?>>(
      future: getOldMessages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");

        List<dynamic> messages = [];
        for (int i = 0; i < (snapshot.data?.length ?? 0); i++) {
          final data = snapshot.data?[i];
          messages.add(
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                date,
                style: TextStyle(color: Colors.grey.shade300, fontSize: 18),
              ),
            ),
          );

          messages.add(
            DailyDisplayWidget(
              quote: data?['quote'],
              author: data?['author'],
              message: data?['message'],
              add: true,
              date: date,
            ),
          );

          messages.add(
            Container(
              width: screenW * (4 / 5),
              height: 1,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: BoxDecoration(color: Colors.white.withAlpha(50)),
            ),
          );

          now = now.subtract(Duration(days: 1));
          date = "${weekday[now.weekday]}, ${months[now.month]} ${now.day}";
        }
        return SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Header
                SizedBox(height: 100),
                ...(messages),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
