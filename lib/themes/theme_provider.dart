import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart';

class ThemeProvider with ChangeNotifier {
  //late is saying we dont have it now but we will have it by the time we use it
  late ThemeData _themeData;
  late SharedPreferences prefs;

  ThemeProvider({bool isDark = false}) {//sets false as the default to ThemeProvider, so it can be used without passing a value
    _themeData = isDark ? Themes.darkMode : Themes.lightMode;
  }

//returns the themedata
  ThemeData get getTheme => _themeData;

//
  Future<void> toggleTheme() async { //makes the function Asynchronous meaning the rest of the program will go on while it works when it can
    prefs = await SharedPreferences.getInstance(); //await make the function wait while this line happens

    if (_themeData == Themes.darkMode) {
      _themeData = Themes.lightMode;
      await prefs.setBool("key-dark-mode", false); 
    } else {
      _themeData = Themes.darkMode;
      await prefs.setBool("key-dark-mode", true);
    }
    
//notifying all the listeners(consumers) about the change.
    notifyListeners();
  }
}
