import 'package:flutter/material.dart';

class HomeScreenCard extends StatefulWidget {
  final String title;
  final String description;
  final String photoURL;
  final String email;
  const HomeScreenCard ({ Key? key, required this.title, required this.description, required this.photoURL, required this.email }): super(key: key);

  @override
  _HomeScreenCardState createState() => _HomeScreenCardState();
}

class _HomeScreenCardState extends State<HomeScreenCard> {
  @override
  Widget build(BuildContext context) {
    return homescreenCard();
  }

  Widget homescreenCard() {
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
                  backgroundImage: NetworkImage(widget.photoURL),
                ),
                title: Text(widget.title),
                subtitle: Text(widget.email),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ),
            Container(
              child: Stack(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                Image.network("https://source.unsplash.com/random/1920x1080")
              ]),
            ),
            Column(
              children: [
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
