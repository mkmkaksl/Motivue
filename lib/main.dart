import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(QuoteAdapter());

  quoteBox = await Hive.openBox<Quote>('quoteBox');

  runApp(
    MaterialApp(
      home: HomePage(),
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
    ),
  );
}
