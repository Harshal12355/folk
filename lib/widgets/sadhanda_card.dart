import 'package:flutter/material.dart';

class SadhanaCard extends StatefulWidget {
  final String title;
  final String description;
  const SadhanaCard({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  _SadhanaCardState createState() => _SadhanaCardState();
}

class _SadhanaCardState extends State<SadhanaCard> {
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
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {},
              child: ListTile(
                minLeadingWidth: 50,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://source.unsplash.com/random/200x200"),
                ),
                title: Text(widget.title),
                subtitle: Text("Boom Boom"),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Number of rounds: ",
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(child: Text(widget.description)),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
