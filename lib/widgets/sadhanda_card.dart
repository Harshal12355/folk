import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:folk_boys/screens/sadhana_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/services.dart';

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
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        width: double.maxFinite,
        // height: double.maxFinite,
        child: _body());

    // Function to create the post widgets
  }

  Widget _body() {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: OpenContainer(
        tappable: false,
        transitionDuration: Duration(milliseconds: 500),
        closedElevation: 0,
        openElevation: 0,
        closedColor: Colors.transparent,
        closedBuilder: (BuildContext c, VoidCallback action) => Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          elevation: 0,
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
                  icon: Icon(Icons.edit),
                  onPressed: action,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Number of Rounds: ",
                          style: GoogleFonts.montserrat(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.rounds.toString() + ' rounds '}',
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 10, top: 5),
                    child: Row(
                      children: [
                        Text(
                          "Time listening to lectures: ",
                          style: GoogleFonts.montserrat(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${(widget.lectures / 60).floor() > 0 ? (widget.lectures / 60).floor().toString() + ' hrs ' : ''} ${(widget.lectures % 60) > 0 ? (widget.lectures % 60).toString() + ' mins ' : ''}',
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 5, bottom: 10),
                    child: widget.links.length == 0
                        ? null
                        : Text(
                            "Links:",
                            style: GoogleFonts.montserrat(fontSize: 20),
                          ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20, bottom: 10, right: 20),
                      child: Wrap(
                        spacing: 8,
                        children: [
                          for (var link in widget.links)
                            Chip(
                              avatar: _getIcon(link),
                              label: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                    child: Text(
                                      link,
                                      overflow: TextOverflow.ellipsis,
                                      // style: TextStyle(
                                      //   color: Colors.blue,
                                      //   decoration: TextDecoration.underline,
                                      // ),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.blue,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onDoubleTap: () {
                                      Clipboard.setData(
                                              new ClipboardData(text: link))
                                          .then((_) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                margin:
                                                    EdgeInsets.only(
                                                        bottom: 85,
                                                        right: 90,
                                                        left: 20),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.greenAccent,
                                                content: Text(
                                                    "Link copied to clipboard!")));
                                      });
                                    },
                                    onTap: () => launch(link)),
                              ),
                            ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
        openBuilder: (BuildContext c, VoidCallback action) => SadhanaForm(
          linkString: widget.links,
          heading: 'Edit',
          rounds: widget.rounds,
          lectures: widget.lectures,
          id: widget.id,
        ),
      ),
      // actions: <Widget>[
      //   Card(
      //     shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(20))),
      //     color: Colors.yellow[800],
      //     child: IconSlideAction(
      //       caption: 'Pin',
      //       color: Colors.transparent,
      //       icon: Icons.pin,
      //       onTap: deleteDialog,
      //     ),
      //   )
      // ],
      secondaryActions: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: Colors.red,
          child: IconSlideAction(
            caption: 'Delete',
            color: Colors.transparent,
            icon: Icons.delete,
            onTap: deleteDialog,
          ),
        )
      ],
    );
  }

  Widget? _getIcon(link) {
    if (link.contains(new RegExp(r'youtu[\.]?be', caseSensitive: false)))
      return Padding(
        padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
        child: Icon(
          FontAwesomeIcons.youtube,
          color: Colors.red,
        ),
      );
    else
      return null;
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

  void deleteDialog() {
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
  }
}
