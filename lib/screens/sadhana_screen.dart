import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:folk_boys/screens/sadhana_form.dart';
import 'package:folk_boys/widgets/sadhanda_card.dart';
import 'package:animations/animations.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:firestore_ui/firestore_ui.dart';

class Sadhana extends StatefulWidget {
  @override
  _SadhanaState createState() => _SadhanaState();
}

class _SadhanaState extends State<Sadhana> {
  final user = FirebaseAuth.instance.currentUser!;
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FirestoreAnimatedList(
          debug: false,
          key: animatedListKey,
          duration: Duration(milliseconds: 370),
          query: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('sadhanaCards')
              .orderBy('timestamp', descending: true),
          onLoaded: (snapshot) =>
              print("Received on list: ${snapshot.docs.length}"),
          itemBuilder: (
            BuildContext context,
            DocumentSnapshot? snapshot,
            Animation<double> animation,
            int i,
          ) =>
            ScaleTransition(
            scale: animation,
            child: SadhanaCard(
              id: snapshot!.id,
              timeAgo: timeago.format(snapshot.data()!['timestamp'].toDate()),
              rounds: snapshot.data()!["rounds"],
              lectures: snapshot.data()!["time"],
              links: snapshot.data()!["links"],
            ),
          ),
        ),
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
          openBuilder: (BuildContext c, VoidCallback action) => SadhanaForm(linkString: []),
          tappable: true,
        ));
  }
}
