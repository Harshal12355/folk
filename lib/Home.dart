import 'package:flutter/material.dart';

class SadhanaCard extends StatefulWidget {
  @override
  _SadhanaCardState createState() => _SadhanaCardState();
}

class _SadhanaCardState extends State<SadhanaCard> {
  @override
  Widget build(BuildContext context) {
    return SCard();
  }

  Widget SCard() {
    return Container(
      padding: EdgeInsets.fromLTRB(10,10,10,0),
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Text("Hello"),
      ),
    );
  }

  Widget getPost() {
    // Function to create the post widgets

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 20),
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [

              GestureDetector(
                onTap: () {},
                child: ListTile(
                  minLeadingWidth: 50,
                  leading: Text("Rock Respawn"),
                  title: Text("Gandustan"),
                  subtitle: Text("Boom Boom"),
                  trailing:
                  GestureDetector(
                    child:Icon(Icons.more_vert),
                  ),
                ),
              ),
              Container(
                child: Image.network("https://source.unsplash.com/random"),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ]
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(child: Text("Da wae of the gandu")),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

