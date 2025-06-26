import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      home: HomePage(),
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
    ),
  );
}
