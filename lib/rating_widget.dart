import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:html';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'Barlow'),
      home: rating('Loose','Neutral','Snug','favorite')

  ));
}

Widget image(String asset) {
  return Transform.scale(scale: 0.7,child:Image.asset(
    asset,
    height: 24.0,
    width: 24.0,
    fit: BoxFit.fitHeight,
    color: HexColor('#00CED3'),
   )
  );
}

class rating extends StatelessWidget {
  final String txt1,txt2,txt3,title;
  rating(this.txt1,this.txt2,this.txt3,this.title);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        child:
            Container(height:93,width:288,child:
            Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: HexColor('#E0E0E0')),
                  ),
                ),
              child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(txt1, style: TextStyle(fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 12, color: HexColor('#9B9B9B'))),
                Text(txt2, style: TextStyle(fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 12, color: HexColor('#9B9B9B'))),
                Text(txt3, style: TextStyle(fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 12, color: HexColor('#9B9B9B')))
              ],),),
              SizedBox(height:5),
               RatingBar(
                initialRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: image('assets/images/Full_Circle.png'),
                  //half: Image.asset('assets/heart_half.png'),
                  empty: image('assets/images/Empty_Circle.png'),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 8.5),
                onRatingUpdate: (rating) {
                  var firebaseUser = FirebaseAuth.instance.currentUser;
                  final firestoreInstance = FirebaseFirestore.instance;
                  if(rating!=null)
                    firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                        .update({title: rating}).then((_) {
                      print("success!");
                    });
                  print(rating);
                },
                updateOnDrag: true,
              ),
              SizedBox(height:5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.start,children: [
                 Text('1', style: TextStyle(fontWeight: FontWeight.w400,
                     //fontStyle: FontStyle.italic,
                     fontFamily: 'Barlow',
                     fontSize: 20, color: HexColor('#222222'))),
                Text('2', style: TextStyle(fontWeight: FontWeight.w400,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 20, color: HexColor('#222222'))),
                Text('3', style: TextStyle(fontWeight: FontWeight.w400,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 20, color: HexColor('#222222'))),
                Text('4', style: TextStyle(fontWeight: FontWeight.w400,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 20, color: HexColor('#222222'))),
                Text('5', style: TextStyle(fontWeight: FontWeight.w400,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 20, color: HexColor('#222222'))),
              ],)


            ],)
          )
    );


  }
}