import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '/Z3a-b.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'clippy_flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MainLogin(),
    );
  }
}

class MainLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child: Stack(children: [
          Image(
            image: AssetImage('assets/images/bg.png'),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
           Positioned(top:88,left: 16,child:Text("Let's Connect", textAlign: TextAlign.left,
             style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.w600,
                 //fontStyle: FontStyle.italic,
                 fontFamily: 'Barlow',
                 fontSize: 32),
          )),
          Positioned(top:160,left: 16, child:RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height:1.5,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 20),
              children: <TextSpan>[
                TextSpan(text: 'Welcome'),
                TextSpan(text: '\nHow would you like to continue?', style: TextStyle(color:HexColor('#222222'), fontSize:16))
              ],
            ),
          )),
          Positioned(top:230,left: 16, child:Container(height: 48.0,
              width: 378.0,
              decoration: new BoxDecoration(

                  color: Colors.white,
                  borderRadius: new BorderRadius.all(const  Radius.circular(25.0))

              ),
           child:FlatButton(
            onPressed: () async{
              WidgetsFlutterBinding.ensureInitialized();
              await Firebase.initializeApp();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmailLog()),
              );
            },
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: Row(children: [
              SizedBox(width: 22),
              Container(child:Image.asset('assets/images/icon_connect_email.png')),
              SizedBox(width: 20),
              Text('Connect with Email',
              style: TextStyle(
                  color: HexColor('#222222'),
                  fontWeight: FontWeight.w500,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16),),
             ]),
          ))),

          Positioned(top:286,left: 16, child:Container(height: 48.0,
              width: 378.0,
              decoration: new BoxDecoration(

                  color: Colors.white,
                  borderRadius: new BorderRadius.all(const  Radius.circular(25.0))

              ),
              child:FlatButton(
                onPressed: () {},
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Row(children: [
                  SizedBox(width: 22),
                  Container(child:Image.asset('assets/images/icon_connect_google.png')),
                  SizedBox(width: 20),
                  Text('Connect with Google',
                    style: TextStyle(
                        color: HexColor('#222222'),
                        fontWeight: FontWeight.w500,
                        //fontStyle: FontStyle.italic,
                        fontFamily: 'Barlow',
                        fontSize: 16),),
                ]),
              ))),

          Positioned(top:342,left: 16, child:Container(height: 48.0,
              width: 378.0,
              decoration: new BoxDecoration(

                  color: Colors.white,
                  borderRadius: new BorderRadius.all(const  Radius.circular(25.0))

              ),
              child:FlatButton(
                onPressed: () {},
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Row(children: [
                  SizedBox(width: 22),
                  Container(child:Image.asset('assets/images/icon_connect_fb.png')),
                  SizedBox(width: 20),
                  Text('Connect with Facebook',textAlign: TextAlign.left,
                    style: TextStyle(
                        color: HexColor('#222222'),
                        fontWeight: FontWeight.w500,
                        //fontStyle: FontStyle.italic,
                        fontFamily: 'Barlow',
                        fontSize: 16),),
                ]),
              ))),

          Positioned(top:589,left: 200, child:RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w400,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 12),
              children: <TextSpan>[
                TextSpan(text: '                                                     ______'),
                TextSpan(text: '\n\n          By logging in, you agree to the'),
                TextSpan(text: '\n privacy policy ', style: TextStyle(fontWeight:FontWeight.w600)),
                TextSpan(text: 'and'),
                TextSpan(text: ' terms of service', style: TextStyle(fontWeight:FontWeight.w600)),
              ],
            ),
          )),
         ]
        ),

      ),

    );

  }
}

