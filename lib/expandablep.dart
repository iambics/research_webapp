// Flutter code sample for AnimatedContainer

// The following example (depicted above) transitions an AnimatedContainer
// between two states. It adjusts the [height], [width], [color], and
// [alignment] properties when tapped.

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_pro/carousel_pro.dart';


//void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  //static const String _title = 'Flutter Code Sample';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: _title,
      home: Scaffold(
        //appBar: AppBar(title: const Text(_title)),
        body: Panelz1a(),
      ),
    );
  }
}

class Panelz1a extends StatefulWidget {
  Panelz1a({Key key}) : super(key: key);

  @override
  _Panelz1aState createState() => _Panelz1aState();
}

class _Panelz1aState extends State<Panelz1a> {
  bool selected = true;
  double width;
  double height;



  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Column(mainAxisAlignment:MainAxisAlignment.spaceEvenly, children:[

         //SizedBox(height:30),
         AnimatedContainer(constraints: BoxConstraints(minWidth: 360, maxWidth: 375),
           padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(
              color: selected ? Colors.transparent : Colors.transparent,//Hexcolor('#00CED3'),
              borderRadius: new BorderRadius.only(
                  topLeft:  const  Radius.circular(15.0),
                  topRight: const  Radius.circular(15.0))
          ),
          width: 328*width/360,
          height: 330,//selected ? height+100 : 0.8*height,
          //color: selected ? Colors.blue : Colors.blue,
          //alignment:
          //selected ? FractionalOffset.center : FractionalOffset.topCenter,
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
          child: Container(
            //height: 200.0,
            //width: 375.0,
            //color: HexColor('#00CED3'),
            decoration: new BoxDecoration(

                //color: HexColor('222222').withOpacity(0.15),
                color: HexColor('8EE2E4'),
                borderRadius: new BorderRadius.only(
                    topLeft:  const  Radius.circular(15.0),
                    topRight: const  Radius.circular(15.0))
            ),

            child:
               Carousel(
                boxFit: BoxFit.contain,
                autoplay: false,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 1000),
                dotSize: 5.0,
                dotIncreasedColor: HexColor('#222222'),
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                dotVerticalPadding: 1,//height/640*10,
                showIndicator: true,
                indicatorBgPadding: height/640*45,
                images: [
                  //Card(
                  //child:
                  Container(padding: EdgeInsets.fromLTRB(16,16,16,0),child:panel1),
                  Container(padding: EdgeInsets.fromLTRB(16,16,16,0),child:panel2),
                  Container(padding: EdgeInsets.fromLTRB(16,16,16,0),child:panel3),
                ],
              )),


            ),
          //carousel,//selected ? collapsedp : carousel ,
         ]
        ),
    );
  }
}

Widget collapsedp = Center(child:
Container(height: 152.0,
    width: 400.0,
    decoration: new BoxDecoration(
        //color: HexColor('222222').withOpacity(0.15),
        borderRadius: new BorderRadius.only(
            topLeft:  const  Radius.circular(15.0),
            topRight: const  Radius.circular(15.0))
    ),

    child:  Column
      (mainAxisSize: MainAxisSize.max, children: <Widget>[
      Center(child:Opacity(opacity:0.6,child:Icon(Icons.keyboard_arrow_up))),
      Center(child:
       Text('Learn more',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222').withOpacity(0.6),//Colors.grey[800],
              fontWeight: FontWeight.w600,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Barlow',
              fontSize: 16))),

      Center(child:
       Container(padding: EdgeInsets.fromLTRB(16, 16, 16, 16), child: Text('Get a virtual shoe fitting-\nanytime, anywhere',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w600,
              //fontStyle: FontStyle.italic,
              height: 1.5,
              fontFamily: 'Barlow',
              fontSize: 16)))),
    ])));

Widget carousel = Center(
  child:
  Container(
    height: 280.0,
    //width: 375.0,
    //color: HexColor('#00CED3'),
    decoration: new BoxDecoration(

        color: HexColor('222222').withOpacity(0.15),
        //color: HexColor('8EE2E4'),
        borderRadius: new BorderRadius.only(
            topLeft:  const  Radius.circular(15.0),
            topRight: const  Radius.circular(15.0))
    ),
    child:

    Column(children: <Widget> [
      //Container(alignment: Alignment.topCenter,child:Icon(Icons.keyboard_arrow_down)),
      Expanded(child:
       Carousel(
        boxFit: BoxFit.contain,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 2000),
        dotSize: 5.0,
        dotIncreasedColor: HexColor('#222222'),
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
        dotVerticalPadding: 5.0,
        showIndicator: true,
        indicatorBgPadding: 35.0,
        images: [
          //Card(
          //child:
          Container(padding: EdgeInsets.all(16),child:panel1),
          Container(padding: EdgeInsets.all(16),child:panel2),
          Container(padding: EdgeInsets.all(16),child:panel3),
        ],
      )),
    ],

    ),
  ),
);

Widget panel2 =
   Column  (
    children: <Widget>[
      //SizedBox(height:10),
      Image.asset('assets/images/Z1B.png', fit: BoxFit.contain),
      SizedBox(height:10),
      Center(child:
      Text('Bespoke Sneaker Sweepstakes',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w600,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Barlow',
              fontSize: 20))),
      SizedBox(height:5),
      Center(child:
      Text('50 lucky participants will\n win custom-fitted shoes.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w400,
              height: 1.5,
              fontFamily: 'Barlow',
              fontSize: 16))),
    ]);

Widget panel1 = Column
  (mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      //SizedBox(height:10),
      Image.asset('assets/images/Z1A.png', fit: BoxFit.fill),
      SizedBox(height:10),
      Center(child:
       Text('Engage',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w600,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Barlow',
              fontSize: 20))),
      SizedBox(height:5),
      Center(child:
      Text('Shape the future of footwear.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w400,
              height:1.5,
              fontFamily: 'Barlow',
              fontSize: 16))),
    ]);

Widget panel3 = Column(
    children: <Widget>[
      //SizedBox(height:10),
      Image.asset('assets/images/Z1C.png', fit: BoxFit.fill),
      SizedBox(height:10),
      Center(child:
      Text('ETA',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w600,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Barlow',
              fontSize: 20))),
      SizedBox(height:5),
      Center(child:
      Text('Full participation will take\n approximately 15 minutes.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w400,
              //fontStyle: FontStyle.italic,
              height: 1.5,
              fontFamily: 'Barlow',
              fontSize: 16))),
    ]);