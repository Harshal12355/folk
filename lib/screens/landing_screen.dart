import 'package:flutter/material.dart';
import 'package:folk_boys/screens/sadhana_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Sadhana(),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  static List<Widget> _pageName = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Sadhana',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: _pageName.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.brown.shade600,
                    child: const Text('GG'),
                    radius: 25,
                    // backgroundImage: NetworkImage(userAvatarUrl),  <- for when we have an image
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[700]!,
              hoverColor: Colors.grey[900]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[900]!,
              color: Colors.white,
              tabs: [
                GButton(
                  icon: Icons.home_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.menu_book_rounded,
                  text: 'Sadhana',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
