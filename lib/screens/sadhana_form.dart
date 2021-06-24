import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SadhanaForm extends StatefulWidget {
  SadhanaForm({Key? key}) : super(key: key);

  @override
  _SadhanaFormState createState() => _SadhanaFormState();
}

class _SadhanaFormState extends State<SadhanaForm> {
  final TextEditingController roundsCon = new TextEditingController();
  final TextEditingController lecturesCon = new TextEditingController();
  final TextEditingController linksCon = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> linkString = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter Details",
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
                  style: GoogleFonts.montserrat(),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  controller: lecturesCon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the time spent!';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                      labelStyle: GoogleFonts.montserrat(),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      labelText: 'Time spent listening to lectures'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  style: GoogleFonts.montserrat(),
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
                              linkString.add(linksCon.text);
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
                      linkString.add(linksCon.text);
                    });
                    linksCon.clear();
                  },
                ),
                SizedBox(height: 20),
                Wrap(runSpacing: 1, spacing: 8, children: [
                  for (var link in linkString)
                    Chip(
                        label: Text(
                          link,
                          style: GoogleFonts.montserrat(),
                        ),
                        onDeleted: () {
                          setState(() {
                            linkString.remove(link);
                          });
                        }),
                ]),
                Spacer(),
                FloatingActionButton.extended(
                  onPressed: () {
                    _sendDataBack(context);
                  },
                  label: Text(
                    'Add',
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
    String lecturesBack = lecturesCon.text;
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('sadhanaCards')
          .add({
        "rounds": int.parse(roundsBack),
        "time": int.parse(lecturesBack),
        "links": linkString,
        "timestamp": DateTime.now(),
      });
      Navigator.pop(context);
    }
  }
}
