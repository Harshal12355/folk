import 'package:flutter/material.dart';
import 'package:folk_boys/widgets/sadhanda_card.dart';

class Sadhana extends StatefulWidget {
  @override
  _SadhanaState createState() => _SadhanaState();
}

class _SadhanaState extends State<Sadhana> {
  final TextEditingController roundsCon = new TextEditingController();
  final TextEditingController lecturesCon = new TextEditingController();
  final TextEditingController linksCon = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: Text('Sadhana Information'),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: roundsCon,
              decoration: new InputDecoration(
                hintText: "Number of rounds",
              ),
            ),
            TextFormField(
              controller: lecturesCon,
              decoration: new InputDecoration(
                hintText: "Time spent listening to lectures",
              ),
            ),
            TextFormField(
              controller: linksCon,
              decoration: new InputDecoration(
                hintText: "Links",
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          //textColor: Colors.red,
          //onPressed: () => Navigator.pop(context),
          onPressed: () {
            _sendDataBack(context);
          },
          child: Text('Submit'),
        ),
      ],
    );

    return Scaffold(
      body: ListView(children: <Widget>[
        for (int i = 0; i < 10; i++)
          SadhanaCard(name: "Gaurav", rounds: 5, lectures: 2, links: <String>[
            "https://github.com/Harshal12355/flashcards/blob/master/lib/Flashcard_View.dart",
            "https://www.youtube.com/watch?v=tbGqmS15ALY"
          ])
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

  void _sendDataBack(BuildContext context) {
    String roundsBack = roundsCon.text;
    String lecturesBack = lecturesCon.text;
    String linksBack = linksCon.text;
    print(roundsBack);
    print(lecturesBack);
    print(linksBack);
  }
}
