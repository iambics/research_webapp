import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '/T1.dart';
import '/slide_transition.dart';
import '/bubble_level.dart';
import '/PrimaryButton.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: _title,
      home: Scaffold(
           body: Scan(),
      ),
    );
  }
}

class Scan extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Scan",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w600,
            //fontStyle: FontStyle.italic,
            fontFamily: 'Barlow',
            fontSize: 24)),
        backgroundColor:HexColor('#A5E0E5'),
        centerTitle: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),color:HexColor('#222222'),
            onPressed:() => Navigator.pop(context)),
        elevation: 0,
      ),
      body:
     Stack(children: [
       Container(
         //padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
           width: width,
           height:height,
           child:
           Image.asset('assets/images/bg_scan_v1.png', fit: BoxFit.cover)),
       Container(padding: EdgeInsets.only(top:16),child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
         InkWell(
           // When the user taps the button, show a snackbar.
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => P(side:'Left')),
               );
             },
             child:column('Left', width, height)),
         InkWell(
           // When the user taps the button, show a snackbar.
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => P(side:'Right')),
               );
             },
             child:column('Right', width, height)),
       ],)),
       Positioned(top: 290*height/640, left:32*width/360, child: ButtonTheme(
           minWidth: 328.0,
           height: 48.0,child:
        RaisedButton(
         child: new Text('VIEW SCAN TUTORIAL', style: TextStyle(
             color: HexColor('#FFFFFF'),
             fontWeight: FontWeight.w700,
             //fontStyle: FontStyle.italic,
             fontFamily: 'Barlow',
             fontSize: 16),),
         shape: new RoundedRectangleBorder(
             borderRadius: BorderRadius.all(Radius.circular(height / 2))),
         color: Colors.black,
         textColor: Colors.black87,
         onPressed: (){Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => T1()),
         );},
       ))),
        Positioned(top: 350*height/640, left:32*width/360, child:PrimaryButton(
         key: new Key('previous scans'),
         text: 'VIEW PREVIOUS SCANS',
         height: 48.0,
         width: 328.0,
         onPressed: (){},
       ))
   ],)
   );
  }

}

Widget column(String side,double width,double height){

  return

    Column(children: [
      Container(width:156*width/360,height:196*height/640, decoration: new BoxDecoration(
          color: HexColor('FFFFFF'),
          borderRadius: BorderRadius.only(
              topLeft:  const  Radius.circular(10.0),
              topRight: const  Radius.circular(10.0))),child:
       Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        Text('$side'' Foot',style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w600,
            //fontStyle: FontStyle.italic,
            fontFamily: 'Barlow',
            fontSize: 24)),
        Text('No scans \ndetected',style: TextStyle(color: HexColor('#828282'),
            fontWeight: FontWeight.w400,
            height: 0.7,
            fontFamily: 'Barlow',
            fontSize: 16)),
      ],)
      ),

      Container(padding: EdgeInsets.only(left:16,right: 8),width:156*width/360,height:48*height/640,
          decoration: new BoxDecoration(
          color: HexColor('00CED3'),
          borderRadius: BorderRadius.only(
              bottomLeft:  const  Radius.circular(10.0),
              bottomRight: const  Radius.circular(10.0))),child:
       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
         Text('SCAN',style: TextStyle(color: HexColor('#222222'),
           fontWeight: FontWeight.w700,
           fontFamily: 'Barlow',
           fontSize: 16)),
        Icon(Icons.arrow_forward_ios, color: HexColor('#FFFFFF')),

      ],))

     ]
    );

}


class P extends StatelessWidget {
  P({this.side});
  final String side;
  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    return new Scaffold(backgroundColor: HexColor('#A5E0E5'),
        appBar: new AppBar(
          title: Text("Scan",style: TextStyle(color: HexColor('#222222'),
              fontWeight: FontWeight.w600,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Barlow',
              fontSize: 24)),
          backgroundColor:HexColor('#A5E0E5'),
          centerTitle: true,
          leading: IconButton(icon:Icon(Icons.arrow_back),color:HexColor('#222222'),
              onPressed:() => Navigator.pop(context)),
          elevation: 0,
        ),
        body: Container(padding:EdgeInsets.fromLTRB(16.0,130,16,16), width:width,height:height,
            decoration: new BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                    topLeft:  const  Radius.circular(10.0),
                    topRight: const  Radius.circular(10.0))),child:
             Column(children:[

               Text('Rescan'' $side'' Foot?',style: TextStyle(color: HexColor('#00CED3'),
                   fontWeight: FontWeight.w600,
                   //fontStyle: FontStyle.italic,
                   fontFamily: 'Barlow',
                   fontSize: 32)),
               Text('\nWould you like to rescan\nyour left foot? You can\nalways review your previous\nscan data.\n\nDo you wish to continue?',textAlign: TextAlign.center,
                   style: TextStyle(color: HexColor('#222222'),
                   fontWeight: FontWeight.w400,
                   fontFamily: 'Barlow',
                   height: 1.5,
                   fontSize: 24)),
               SizedBox(height:100),
               PrimaryButton(
                 key: new Key('continue to rescan'),
                 text: 'CONTINUE TO RESCAN',
                 height: 48.0,
                 width: 328.0,
                 onPressed: (){
                   Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => bubble_level(view:'Top',side:side)),
                 );
                 },
               )

             ])

        )

    );
  }

}