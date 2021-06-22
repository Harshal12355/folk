import 'package:flutter/material.dart';
import 'package:folk_boys/provider/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
        ),
        onPressed: () {
          final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin();
        },
        icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
        label: Text('Sign Up with Google'),
      ),
    );
  }
}
