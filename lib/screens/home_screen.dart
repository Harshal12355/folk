import 'package:flutter/material.dart';
import 'package:folk_boys/widgets/home_screen_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        HomeScreenCard(
          title: 'A',
          description: 'Bruh A',
        ),
        HomeScreenCard(
          title: 'B',
          description: 'Bruh B',
        ),
        HomeScreenCard(
          title: 'C',
          description: 'Bruh C',
        ),
      ]),
    );
  }
}
