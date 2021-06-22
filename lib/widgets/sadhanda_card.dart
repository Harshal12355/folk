import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SadhanaCard extends StatefulWidget {
  final String name;
  final int rounds;
  final int lectures;
  final List<String> links;

  const SadhanaCard({
    Key? key,
    required this.name,
    required this.rounds,
    required this.lectures,
    required this.links,
  }) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                title: Text(widget.name),
                subtitle: Text("Boom Boom"),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
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
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Links:",
                    style: GoogleFonts.montserrat(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 10),
                  child: ListView.builder(
                    itemCount: widget.links.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: new InkWell(
                            child: new Text(
                              widget.links[index],
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () => launch(widget.links[index])),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
