import 'package:flutter/material.dart';
import 'package:folk_boys/widgets/sadhanda_card.dart';

class Sadhana extends StatefulWidget {
  @override
  _SadhanaState createState() => _SadhanaState();
}

class _SadhanaState extends State<Sadhana> {
  final roundsCon = new TextEditingController();

  final AlertDialog dialog = AlertDialog(
    title: Text('Sadhana Information'),
    contentPadding: EdgeInsets.zero,
    content: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(),
        ],
      ),
    ),
    actions: [
      TextButton(
        //textColor: Colors.red,
        //onPressed: () => Navigator.pop(context),
        onPressed: () {},
        child: Text('Submit'),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
SadhanaCard(name: "Gaurav", rounds: 5, lectures: 2, links: <String>["https://github.com/Harshal12355/flashcards/blob/master/lib/Flashcard_View.dart",
"https://github.com/Harshal12355/flashcards/blob/master/lib/Flashcard_View.dart"]),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[600],
        onPressed: () {
          showDialog<void>(context: context, builder: (context) => dialog);
        },
      ),
    );
  }
}
