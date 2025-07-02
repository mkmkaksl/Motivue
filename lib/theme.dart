import 'package:flutter/material.dart';
import 'package:Motivue/library.dart';

var screenW = LayoutConfig.width;
var screenH = LayoutConfig.height;
const padding = 10.0;
double authorFS = 18;
// Color bgCircleColor = Colors.white;
Color bgCircleColor = AppTheme.authorText;

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

class AppTheme {
  static const darkBlue = Color(0xFF1A1A2E);
  static const primaryBlue = Color(0xFF16213E);
  static const lightBlue = Color(0xFF0F3460);

  static const mainText = Colors.white;
  static const authorText = Color(0xFFFECA57);

  static const backgroundColors = [darkBlue, primaryBlue, lightBlue];
  static BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: backgroundColors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
  static Gradient textGradient = LinearGradient(
    colors: [authorText, mainText],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0.6, 1],
  );

  static final TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: mainText,
    ),
    bodyLarge: TextStyle(fontSize: 12, color: mainText),
  );

  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryBlue,
    colorScheme: ColorScheme.light(
      primary: primaryBlue,
      secondary: darkBlue,
      surface: mainText,
      error: Colors.red,
    ),
    textTheme: textTheme,
  );
}
