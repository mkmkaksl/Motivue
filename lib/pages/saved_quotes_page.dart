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
      padding: EdgeInsets.all(padding),
      child: SingleChildScrollView(
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
                        GradientText(
                          gradient: LinearGradient(
                            colors: [AppTheme.authorText, Colors.white],
                          ),
                          text: "Saved Quotes:",
                          style: TextStyle(
                            fontSize: 35,
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
                        SizedBox(height: 30),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
