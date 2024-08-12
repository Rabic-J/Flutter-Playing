import 'package:flutter/material.dart';

class Themes {
  static final lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade100,
      primary: Colors.red.shade100,
      secondary: Colors.grey.shade600,
      tertiary: Colors.grey.shade900,
    ),
  );

  static final darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: Colors.blue.shade700,
      secondary: Colors.grey.shade700,
      tertiary: Colors.grey.shade600,
    ),
  );
}

// //LightTheme
// ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     colorScheme: ColorScheme.light(
//       background: Colors.grey.shade100,
//       primary: Colors.red.shade100,
//       secondary: Colors.grey.shade300,
//       tertiary: Colors.grey.shade400,
//     ),
//   );

// TextStyle lightTextStyle = const TextStyle(
//   fontSize: 20,
//   color: Colors.black,
// );
// TextTheme lightTextTheme = TextTheme(
//   bodyLarge: lightTextStyle,
// );

// //DarkTheme
// ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     colorScheme: ColorScheme.dark(
//       background: Colors.grey.shade900,
//       primary: Colors.grey.shade800,
//       secondary: Colors.grey.shade700,
//       tertiary: Colors.grey.shade600,
//     ),
//   );

// TextStyle darkTextStyle = const TextStyle(
//   fontSize: 20,
//   color: Colors.white,
// );
// TextTheme darkTextTheme = TextTheme(
//   bodyLarge: lightTextStyle,
// );