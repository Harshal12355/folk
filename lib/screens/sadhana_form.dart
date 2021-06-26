import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SadhanaForm extends StatefulWidget {
  // SadhanaForm({Key? key}) : super(key: key);
  String? heading;
  int? rounds;
  int? lectures;
  List? linkString;
  String? id;

  SadhanaForm({
    Key? key,
    this.heading,
    this.rounds,
    this.lectures,
    this.linkString,
    this.id,
  }) : super(key: key);

  @override
  _SadhanaFormState createState() => _SadhanaFormState();
}

class _SadhanaFormState extends State<SadhanaForm> {
  late TextEditingController roundsCon = new TextEditingController();
  late TextEditingController lecturesCon = new TextEditingController();
  final TextEditingController linksCon = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // List<String>  = [];
  late Duration initialtimer = new Duration();
  late String? time;

  @override
  void initState() {
    super.initState();
    if (widget.rounds != null) roundsCon.text = widget.rounds.toString();
    initialtimer =
        new Duration(minutes: (widget.lectures != null) ? widget.lectures! : 0);
    time = (widget.lectures != null)
        ? initialtimer.inHours.toString() +
            ' hrs ' +
            (initialtimer.inMinutes % 60).toString() +
            ' mins '
        : null;
    lecturesCon.text = (widget.lectures != null)
        ? initialtimer.inHours.toString() +
            ' hrs ' +
            (initialtimer.inMinutes % 60).toString() +
            ' mins '
        : 'Time Spent Listening to Lectures';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.heading != null
              ? widget.heading! + ' Details'
              : "Enter Details",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  style: GoogleFonts.montserrat(),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of rounds!';
                    }
                    return null;
                  },
                  controller: roundsCon,
                  decoration: new InputDecoration(
                    labelText: "Number of rounds",
                    labelStyle: GoogleFonts.montserrat(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onTap: () {
                    bottomSheet(context, timePicker());
                  },
                  controller: lecturesCon,
                  style: GoogleFonts.montserrat(
                    color: time == null
                        ? Theme.of(context).textTheme.caption!.color
                        : null,
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (time == null || time == '0 hrs 0 mins ') {
                      setState(() {
                        time = null;
                      });
                      return 'Please enter the time spent!';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                    helperText: time != null
                        ? 'Time Spent Listening to Lectures'
                        : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(FontAwesomeIcons.clock)),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  style: GoogleFonts.montserrat(),
                  keyboardType: TextInputType.url,
                  controller: linksCon,
                  decoration: new InputDecoration(
                    labelStyle: GoogleFonts.montserrat(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    labelText: "Links",
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (linksCon.text.isNotEmpty) {
                            setState(() {
                              widget.linkString?.add(linksCon.text);
                            });
                            linksCon.clear();
                          }
                        },
                        icon: Icon(Icons.add)),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-F!#$&-;=?-_~%\[\]]')),
                  ],
                  onFieldSubmitted: (value) {
                    setState(() {
                      widget.linkString?.add(linksCon.text);
                    });
                    linksCon.clear();
                  },
                ),
                SizedBox(height: 20),
                Wrap(runSpacing: 1, spacing: 8, children: [
                  for (var link in widget.linkString!)
                    Chip(
                        label: Text(
                          link,
                          style: GoogleFonts.montserrat(),
                        ),
                        onDeleted: () {
                          setState(() {
                            widget.linkString?.remove(link);
                          });
                        }),
                ]),
                Spacer(),
                FloatingActionButton.extended(
                  onPressed: () {
                    (widget.heading == 'Edit')
                        ? _updateData(context)
                        : _sendDataBack(context);
                  },
                  label: Text(
                    (widget.heading == 'Edit') ? 'Save' : 'Add',
                    style: GoogleFonts.montserrat(),
                  ),
                  icon: Icon(Icons.task_alt),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendDataBack(BuildContext context) {
    String roundsBack = roundsCon.text;
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('sadhanaCards')
          .add({
        "rounds": int.parse(roundsBack),
        "time": initialtimer.inMinutes,
        "links": widget.linkString,
        "timestamp": DateTime.now(),
      });
      Navigator.pop(context);
    }
  }

  void _updateData(BuildContext context) {
    String roundsBack = roundsCon.text;
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('sadhanaCards')
          .doc(widget.id)
          .set({
        "rounds": int.parse(roundsBack),
        "time": initialtimer.inMinutes,
        "links": widget.linkString,
        "timestamp": DateTime.now(),
      }, SetOptions(merge: true));
      Navigator.pop(context);
    }
  }

  Widget timePicker() {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      minuteInterval: 1,
      secondInterval: 1,
      initialTimerDuration: initialtimer,
      onTimerDurationChanged: (Duration changedtimer) {
        setState(() {
          initialtimer = changedtimer;
          (changedtimer.inMinutes > 0)
              ? time = changedtimer.inHours.toString() +
                  ' hrs ' +
                  (changedtimer.inMinutes % 60).toString() +
                  ' mins '
              : time = null;
          (changedtimer.inMinutes > 0)
              ? lecturesCon.text = time!
              : lecturesCon.text = 'Time Spent Listening to Lectures';
        });
      },
    );
  }

  Future<void> bottomSheet(BuildContext context, Widget child,
      {double? height}) {
    return showModalBottomSheet(
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13), topRight: Radius.circular(13))),
        // backgroundColor: Colors.white,
        context: context,
        builder: (context) => Container(
            height: height ?? MediaQuery.of(context).size.height / 3,
            child: Column(
              children: [
                child,
                Center(
                    child: MaterialButton(
                        child: Text('Done'),
                        onPressed: () {
                          Navigator.pop(context);
                        })),
              ],
            )));
  }
}
