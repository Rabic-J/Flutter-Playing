import 'dart:io';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:window_manager/window_manager.dart';
import 'themes/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'pages/loading.dart';
import 'pages/home.dart';
import 'pages/about.dart';
import 'pages/settings.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //required to use platform channels to call native code.

  //Used to limit size on windows to prevent crashing
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(450, 600));
  }
  //connects the setting package to the sharedpreferences package
  await Settings.init(cacheProvider: SharePreferenceCache());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool themeBool = prefs.getBool("key-dark-mode") ??
      false; // ?? is a null check sets value to false if nothing is returned
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) =>
          ThemeProvider(isDark: themeBool), //sets isDark to themeBool
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const Loading(),
          // ignore: prefer_const_constructors
          '/home': (context) => Home(),
          '/about': (context) => const About(),
          // ignore: prefer_const_constructors
          '/settings': (context) => SettingsPage(),
        },
        title: 'Flutter Testing',
        theme: themeProvider.getTheme,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

/*
//Smaller main class code cant use provider
void main() {
runApp(
  MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context)=> const Loading(),
        '/home': (context) => const Home(),
        '/about': (context) => const About(),
      },
      //theme dependent on device settings
      theme: Themes.lightMode,
      darkTheme: Themes.darkMode,
      themeMode: ThemeMode.system,
      

    ));
} 
*/