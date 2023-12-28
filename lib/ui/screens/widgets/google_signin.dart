import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async{
    final googleUser = await googleSignIn.signIn();

    if(googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    updateUserData(credential);
    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }

   Future logout() async {
    await _auth.signOut();
    googleSignIn.disconnect();
  }
  
 Future<void> updateUserData(OAuthCredential credential) {
  CollectionReference ref = _db.collection('Users');
  return ref.add({
    'FullName': user.displayName,
      'Email': user.email,
      'Password': '',
      'Id': user.id,
  });
 } 
}