import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folk_boys/config.dart';
import 'package:folk_boys/provider/google_sign_in.dart';
import 'package:folk_boys/screens/home_screen.dart';
import 'package:folk_boys/screens/sadhana_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Sadhana(),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  static List<String> _pageName = <String>[
    'Home',
    'Sadhana',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final PageController _pageController = PageController(initialPage: 0);
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: Text(_pageName.elementAt(_selectedIndex),
            style: GoogleFonts.montserrat(
                fontSize: 30, fontWeight: FontWeight.w600)),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    user.displayName!,
                    style: GoogleFonts.montserrat(fontSize: 25),
                  ),
                  IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        currentTheme.switchTheme();
                      },
                      icon: Icon(currentTheme.isDark()
                          ? Icons.dark_mode
                          : Icons.light_mode)),
                ],
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 2.5,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                "Logout",
              ),
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            ),
            CupertinoSwitch(value: currentTheme.isDark(),onChanged: (a) {currentTheme.switchTheme();},)
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _widgetOptions,
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                _pageController.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
