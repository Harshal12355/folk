import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:folk_boys/screens/sadhana_form.dart';
import 'package:folk_boys/widgets/sadhanda_card.dart';
import 'package:animations/animations.dart';
import 'package:timeago/timeago.dart' as timeago;

class Sadhana extends StatefulWidget {
  @override
  _SadhanaState createState() => _SadhanaState();
}

class _SadhanaState extends State<Sadhana> {
  final TextEditingController roundsCon = new TextEditingController();
  final TextEditingController lecturesCon = new TextEditingController();
  final TextEditingController linksCon = new TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('sadhanaCards')
                .orderBy('timestamp', descending: true)
                .snapshots()
                ,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
              for (var doc in snapshot.data.docs) {
                print(doc.data()['timestamp'].toDate());
              }
              return ListView(children: <Widget>[
                for (var doc in snapshot.data.docs)
                  SadhanaCard(
                      id: doc.id,
                      timeAgo: timeago.format(doc.data()['timestamp'].toDate()),
                      rounds: doc.data()["rounds"],
                      lectures: doc.data()["time"],
                      links: doc.data()["links"],
                  ),
                SizedBox(height: 20,)
              ]);
            }),
        floatingActionButton: OpenContainer(
          transitionDuration: Duration(milliseconds: 500),
          closedShape: CircleBorder(),
          closedColor: Colors.grey[600]!,
          closedBuilder: (BuildContext c, VoidCallback action) =>
              FloatingActionButton(
            tooltip: "Add New Card",
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.grey[600],
            onPressed: action,
          ),
          openBuilder: (BuildContext c, VoidCallback action) => SadhanaForm(),
          tappable: true,
        ));
  }
}
