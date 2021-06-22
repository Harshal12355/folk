import 'package:flutter/material.dart';
import 'package:folk_boys/widgets/sadhanda_card.dart';

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
        SadhanaCard(title: 'A', description: 'Bruh A',),
        SadhanaCard(title: 'B', description: 'Bruh B',),
        SadhanaCard(title: 'C', description: 'Bruh C',),
      ]),
    );
  }
}