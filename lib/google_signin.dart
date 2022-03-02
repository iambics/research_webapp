/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
  'email',
],);

Future<String> signInWithGoogle() async {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;
  /*firestoreInstance.collection("userdata").doc(firebaseUser.uid)
      .set({"Name":googleSignInAccount.displayName,"Email": googleSignInAccount.email}).then((_) {
    print("success!");
  });*/

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _firebaseAuth.currentUser;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    assert(user.uid == currentUser.uid);
    firestoreInstance.collection("userdata").doc(user.uid)
          .set({
        "Name": googleSignInAccount.displayName,
        "Email": googleSignInAccount.email,
        "Phone_model": androidInfo.model,
        "Android_version": androidInfo.version.release
      },SetOptions(merge : true)).then((_) {
        print("success!");
      });
    //return '$user';
    return user.uid;
  }
  return null;

}

void signOutGoogle() async{
  await googleSignIn.signOut();
  print("User Sign Out");

}
*/
