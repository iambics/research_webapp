import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:iambic_research/bubble_level.dart';
import 'package:iambic_research/splash.dart';
//import 'package:iambic_research/Z2.dart';
import 'package:iambic_research/landing_page.dart';
import 'package:iambic_research/Z3a-b.dart';
import 'package:iambic_research/T4.dart';
import 'package:iambic_research/Tutorial.dart';
import 'dart:js' as js;
import 'package:js/js.dart';
//import 'package:microphone/microphone.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:path/path.dart';
//import 'dart:io';
import '/foot_survey/S.dart';
//void main() => runApp(const MaterialApp(home:Landing_page()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          //primaryColor: Colors.white,
          //canvasColor: Colors.white,
          unselectedWidgetColor: HexColor('#00CED3'), // <-- your color
        ),
        title: 'Iambic Research',
        // Start the app with the "/" named route. In this case, the app starts
        // on the FirstScreen widget.
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => Landing_page(),//Splash(),bubble_level(view:'Inner', side:'Right',angle:100)
          // When navigating to the "/second" route, build the SecondScreen widget.
          //'/landing': (context) => Landing_page(),
          //'/mainlogin': (context) => MainLogin(),
          //'/T0A':(context) => T0A(),
          //'/T0B':(context) => T0B(),
          //'/Emaillog': (context) => EmailLog(),
          //'/T2': (context) => T2(),
          //'/Tutorial': (context) => TutorialList2(),

        },
        //title: "Test App",
        /*home: Scaffold(
        appBar: AppBar(
          title: Text("Call JS Function"),
          backgroundColor: Colors.redAccent,
        ),

        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: ElevatedButton(
                child: Text("Show JS Alert"),
                onPressed: (){
                  js.context.callMethod("getAccel");
                }),
          ),
        )
    ),*/
    );
  }
}

//void main() {
void main() async {
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //var  firebaseUser= FirebaseAuth.instance.currentUser;
  //if(firebaseUser.uid!=null)
     //_firebaseAuth.signOut();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    //remember to remove
    //UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    //js.context.callMethod("getAccel");
    runApp(MyApp());
  });
}

/*void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: Scaffold(
          appBar: AppBar(
            title: Text("Call JS Function"),
            backgroundColor: Colors.redAccent,
          ),

          body: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: ElevatedButton(
                  child: Text("Show JS Alert"),
                  onPressed: (){
                    js.context.callMethod("getAccel");
                  }),
            ),
          )
      ),
    );
  }
}*/

// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs




