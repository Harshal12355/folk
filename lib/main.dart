import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:folk_boys/config.dart';
import 'package:folk_boys/main_page.dart';
import 'package:folk_boys/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
            title: 'Folk',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(), // Provide light theme.
            darkTheme: ThemeData.dark(), // Provide dark theme.
            themeMode: currentTheme.currentTheme(),
            home: HomePage()),
      );
}
