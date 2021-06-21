import 'package:flutter/material.dart';

class Sadhana extends StatefulWidget {
  @override
  _SadhanaState createState() => _SadhanaState();
}

class _SadhanaState extends State<Sadhana> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Sadhana"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

        },
      ),
    );
  }
}
