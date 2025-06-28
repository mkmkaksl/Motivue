import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedQuotesPage extends StatefulWidget {
  const SavedQuotesPage({super.key});

  @override
  State<SavedQuotesPage> createState() => _SavedQuotesPageState();
}

class _SavedQuotesPageState extends State<SavedQuotesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.backgroundGradient,
      padding: EdgeInsets.all(padding),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Header
                SizedBox(height: 100),

                if (quoteBox.values.isEmpty)
                  Text(
                    "No Quotes Saved...",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )
                else if (quoteBox.values.isNotEmpty)
                  ValueListenableBuilder(
                    valueListenable: quoteBox.listenable(),
                    builder: (BuildContext context, Box box, _) {
                      return Column(
                        children: [
                          Text(
                            "Saved Quotes:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: padding),
                          ...(quoteBox.values.map((dynamic quote) {
                            return QuoteBlock(
                              quote: quote.quote,
                              author: quote.author,
                              date: quote.date,
                              delete: true,
                            );
                          }).toList()),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
