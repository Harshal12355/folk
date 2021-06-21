import 'package:flutter/material.dart';
import 'package:folk_boys/screens/landing_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Folk',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(), // Provide light theme.
        darkTheme: ThemeData.dark(), // Provide dark theme.
        themeMode: ThemeMode.system,
        home: Home());
  }
}
