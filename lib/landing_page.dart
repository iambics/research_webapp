import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iambic_research/T4.dart';
import '/slide_transition.dart';
import '/expandablep.dart';
import '/fadein.dart';
import '/Z3a-b.dart';
import 'dart:js' as js;


//void main() => runApp(MyApp());

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Landing_page(),
    );
  }
}*/

class loginbutton extends StatelessWidget {

  /*const loginbutton({
    Key key,
  }) : super(key: key);*/

  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    final FirebaseAuth auth= FirebaseAuth.instance;

    return Stack(alignment: Alignment.center,
      children:[ Align(alignment: FractionalOffset.bottomCenter,child:
       Container(height:112*height/640,
          constraints: BoxConstraints(minWidth: 375, maxWidth: width),
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0)
          ),
          child:Align(alignment: FractionalOffset.bottomCenter,child:
          Padding(padding:EdgeInsets.only(bottom:16),child:Text("© 2022 Iambic Inc.",
            style: TextStyle(
                color: HexColor('#969696'),//Colors.grey[800],
                fontWeight: FontWeight.w400,
                //fontStyle: FontStyle.italic,
                fontFamily: 'Barlow',
                fontSize: 17)),
      )))),
        Positioned(
          bottom:112*height/640-20,//504*height/640,
          //left:(width-152)/2,//130,
          child:
          ButtonTheme(minWidth: 152.0,height: 48.0,child:FlatButton(
            onPressed: () {//Navigator.push(
              //context,
              //MaterialPageRoute(builder: (context) => MainLogin()),
           // );
              //await auth.signInAnonymously();
             //auth.signOut();
              Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => T5B()),
                //SlideRoute(page: MainLogin(),duration: 600,direction: 'Right'),
                SlideRoute(page: T0A(),duration: 600,direction: 'Left'),
              );
              //UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
              //print(auth.currentUser.uid);
          },
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            child: Text("CONNECT",textAlign: TextAlign.center,
                style: TextStyle(
                    color: HexColor('#FFFFFF'),//Colors.grey[800],
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    fontFamily: 'Barlow',
                    fontSize: 16)),
          )),
        ),

    ]);
  }
}


class Landing_page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(alignment: Alignment.center,children:[
        /*Image.asset('assets/images/bg.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),*/
        //Column(mainAxisSize: MainAxisSize.min,children:[
        Container(width: width,height:height,color:HexColor('8EE2E4')),
        Positioned(
            top:55,
            //left:55,
          child:Container(height:90,child:Image.asset(
              'assets/images/Z1ABC.png', fit: BoxFit.fill))),
        /*Positioned(
            top:140,
            //left:55,
            child:Center(child:Text('Research',style: TextStyle(
                color: HexColor('#FFFFFF'),//Colors.grey[800],
                fontWeight: FontWeight.w600,
                //fontStyle: FontStyle.italic,
                fontFamily: 'Barlow',
                fontSize: 28)))),*/
        if(getSmartPhoneOrTablet()!='android' && getSmartPhoneOrTablet()!='apple')
       Positioned(
        top:200,child:Container(width:144,height:144,child:Image.asset(
            'assets/images/Z1A.png', fit: BoxFit.contain))),

          getSmartPhoneOrTablet()=='android' || getSmartPhoneOrTablet()=='apple' ?
        Center(child:FadeIn2(4,Panelz1a())):
        Container(padding:EdgeInsets.fromLTRB(32,96,32,0),child: RichText(
          text: TextSpan(
            style: TextStyle(color: HexColor('#222222'),
                fontWeight: FontWeight.w400,
                height: 1.5,
                fontFamily: 'Barlow',
                fontSize: 16),
            children: <TextSpan>[
              TextSpan(text: "We’re sorry, but our research app ", style: TextStyle(letterSpacing: 0)),
              TextSpan(text: "requires a mobile device",style: TextStyle(fontWeight: FontWeight.w700)),
              TextSpan(text: " with a working camera. Please revisit us using a mobile device."),
            ],
          ),
        )),

        //],
        //),
        if(getSmartPhoneOrTablet()=='android' || getSmartPhoneOrTablet()=='apple')
          //FadeIn2(2,loginbutton()),
          //loginbutton()
        FadeIn2(2,loginbutton())
      ],
     ),
    );


  }
}

