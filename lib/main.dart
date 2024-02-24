import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section13/screens/loading_screen.dart';
import 'package:http/http.dart';
import 'package:section13/themes/dark_mode.dart';
import 'package:section13/themes/light_mode.dart';
import 'package:section13/themes/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
      theme: lightMode, // Use the light mode defined in light_mode.dart
      darkTheme: darkMode, // Use the dark mode defined in dark_mode.dart
      themeMode: themeProvider.isDarkmode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
