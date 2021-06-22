import 'package:firebase_auth/firebase_auth.dart';
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
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: ListView(children: <Widget>[
        for (int i = 0; i < 10; i++)
          HomeScreenCard(
              title: user.displayName!,
              description: 'description',
              photoURL: user.photoURL!,
              email: user.email!),
      ]),
    );
  }
}
