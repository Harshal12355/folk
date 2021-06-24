import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SadhanaCard extends StatefulWidget {
  final String id;
  final int rounds;
  final int lectures;
  final List links;
  final String timeAgo;

  const SadhanaCard({
    Key? key,
    required this.id,
    required this.rounds,
    required this.lectures,
    required this.links,
    required this.timeAgo,
  }) : super(key: key);

  @override
  _SadhanaCardState createState() => _SadhanaCardState();
}

class _SadhanaCardState extends State<SadhanaCard> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return sadhanaCard();
  }

  Widget sadhanaCard() {
    // Function to create the post widgets
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        width: double.maxFinite,
        // height: double.maxFinite,
        child: _body());
  }

  Widget _body() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            minLeadingWidth: 50,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            title: Text(user.displayName!),
            subtitle: Text(widget.timeAgo),
            trailing: IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      contentPadding: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.grey[900],
                      title: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Delete this post?",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, left: 20.0, right: 20.0),
                              child: Text(
                                "This action will remove this post from your profile and cannot be undone.",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      children: <Widget>[
                        Container(
                          height: 0.10,
                          color: Colors.white,
                        ),
                        SimpleDialogOption(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            deleteCard();
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          height: 0.10,
                          color: Colors.white,
                        ),
                        SimpleDialogOption(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "Number of rounds: ${widget.rounds}",
                  style: GoogleFonts.montserrat(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "Amount of time listening to lectures: ${widget.lectures}",
                  style: GoogleFonts.montserrat(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: widget.links.length == 0
                    ? Text(" ")
                    : Text(
                        "Links:",
                        style: GoogleFonts.montserrat(),
                      ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      for (var link in widget.links)
                        Chip(
                          label: InkWell(
                              child: Text(
                                link,
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () => launch(link)),
                        ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> deleteCard() async {
    try {
      print(widget.id);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('sadhanaCards')
          .doc(widget.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
