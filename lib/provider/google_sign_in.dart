import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final _fs = FirebaseFirestore.instance;

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => {
              _fs
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .set({
                'name': FirebaseAuth.instance.currentUser!.displayName,
                'photoURL': FirebaseAuth.instance.currentUser!.photoURL,
                'email': FirebaseAuth.instance.currentUser!.email,
              }, SetOptions(merge: true))
            });

    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
