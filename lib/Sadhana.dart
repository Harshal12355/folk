import 'package:flutter/material.dart';

class Sadhana extends StatefulWidget {
  @override
  _SadhanaState createState() => _SadhanaState();
}

class _SadhanaState extends State<Sadhana> {

  final roundsCon = new TextEditingController();

  static AlertDialog dialog = AlertDialog(
    title: Text('Sadhana Information'),
    //contentPadding: EdgeInsets.zero,
    content: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Enter restaurant",

              ),
              //controller: roundsCon,
              cursorColor: Colors.black,

            ),
          ],
        ),
    ),
    actions: [
      TextButton(
        //textColor: Colors.red,
        //onPressed: () => Navigator.pop(context),
        onPressed: () {  },
        child: Text('ACTION 1'),
      ),
      TextButton(
        //textColor: Colors.red,
        //onPressed: () => Navigator.pop(context),
        child: Text('ACTION 2'),
        onPressed: () {},
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Sadhana"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog<void>(context: context, builder: (context) => dialog);
        },
      ),
    );
  }
}
