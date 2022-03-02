import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'dart:math' as math;
import 'package:flutter_dash/flutter_dash.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'clippy_flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: PathExample(view:'inner',side:'Left'),
    );
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return new Path()
      ..addOval(new Rect.fromCircle(
          center: new Offset(size.width / 2, size.height / 2),
          radius: size.width * 0.45))
      ..addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('clippy_flutter Demo'),
      ),
      body: Center(

        child: Trapezoid(
          cutLength: 60.0,
          edge: Edge.LEFT,
          child: Container(
            color: Colors.teal,
            width: 200.0,
            height: 250.0,

          ),
        ),

      ),

    );
  }
}

class PathExample extends StatelessWidget {
  const PathExample({Key key,@required this.view,@required this.side}) : super(key: key);
  final String view;
  final String side;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(alignment: Alignment.center, children:[
      CustomPaint(
        painter: PathPainter(view,side,width,height),
      ),
      ClipPath(
        clipper: Clipper(view,side,width,height),
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.5),
        ),
      ),
      /*if(view=='Top')
        Positioned(top:height/8,child: Dash(
          direction: Axis.vertical,
          length: 3/4*height,
          dashLength: 12,
          dashColor: Colors.white,
        ))*/
      /*ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: 300,
          color: Colors.amber.shade200,
        ),
      ),*/

    ],

    );
  }
}

class PathPainter extends CustomPainter {
  String view;String side;double width;double height;
  PathPainter(this.view,this.side,this.width,this.height);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    Path path = Path();
    double x1,y1,x2,y2,y3,y4,y0,y00,y0O,y00O;
    double inner_baseh=1.8;
    double outer_baseh=1.53;

    //double y0value() {

      //if(view!='Top') {
        //y0 = height/30;
        //y0=width/30;
         y0=80;
         y00=35;
         y0O=57;
         y00O=30;
      //}
     // return y0;
    //}
    // TODO: do operations here
    switch(view){
      case 'Top':
      //y1=30;y2=y1;y3=394;y4=y3;
      //y1=-height/4;y2=y1;y3=height/4;y4=y3;
        x1=-width/3.5;x2=width/3.5;
        y1=-1.29*x1;y2=y1;y3=1.29*x1;y4=y3;
        break;
      case 'Outline':
      //y1=30;y2=y1;y3=394;y4=y3;
      // y1=-height/4;y2=y1;y3=height/4;y4=y3;
        x1=-width/3.5;x2=width/3.5;
        y1=-1.29*x1;y2=y1;y3=1.29*x1;y4=y3;
        break;
      case 'Inner':
      //y1=-height/4-y0value();y2=-height/4+y0value();y3=height/4-y0value();y4=height/4+y0value();
        //x1=-width/5;x2=width/5;
        x1=-width/6;x2=width/6;
        //y1=-inner_baseh*-width/4+y0;y2=-inner_baseh*-width/4-y0;y3=inner_baseh*-width/4+y0;y4=inner_baseh*-width/4-y0;
        y1=-inner_baseh*-width/4;y2=-inner_baseh*-width/4-y0;y3=inner_baseh*-width/4+y00;y4=inner_baseh*-width/4;
        if(side=='Left'){
          //y1=-height/4+y0value();y2=-height/4-y0value();y3=height/4+y0value();y4=height/4-y0value();
          //x1=-width/5;x2=width/5;
          x1=-width/6;x2=width/6;
          //y1=-inner_baseh*-width/4-y0;y2=-inner_baseh*-width/4+y0;y3=inner_baseh*-width/4-y0;y4=inner_baseh*-width/4+y0;
          y1=-inner_baseh*-width/4-y0;y2=-inner_baseh*-width/4;y3=inner_baseh*-width/4;y4=inner_baseh*-width/4+y00;
        }
        break;
      case 'Outer':
      //y1=-height/4+y0value();y2=-height/4-y0value();y3=height/4+y0value();y4=height/4-y0value();
        //x1=-width/5;x2=width/5;
        x1=-width/6*1.2;x2=width/6*1.2;
        //y1=-outer_baseh*-width/4-y0;y2=-outer_baseh*-width/4+y0;y3=outer_baseh*-width/4-y0;y4=outer_baseh*-width/4+y0;
        y1=-outer_baseh*-width/4-y0O;y2=-outer_baseh*-width/4;y3=outer_baseh*-width/4;y4=outer_baseh*-width/4+y00O;
        if(side=='Left'){
          //y1=-height/4-y0value();y2=-height/4+y0value();y3=height/4-y0value();y4=height/4+y0value();
          //x1=-width/5;x2=width/5;
          x1=-width/6*1.2;x2=width/6*1.2;
          //y1=-outer_baseh*-width/4+y0;y2=-outer_baseh*-width/4-y0;y3=outer_baseh*-width/4+y0;y4=outer_baseh*-width/4-y0;
          y1=-outer_baseh*-width/4;y2=-outer_baseh*-width/4-y0O;y3=outer_baseh*-width/4+y00O;y4=outer_baseh*-width/4;
        }
        break;
    }
    //x1=8;x2=292;
    //x1=-width/3.5;x2=width/3.5;
    path.moveTo(1.3*x1, 1.3*y1);
    path.lineTo(1.3*x2,1.3*y2);
    path.lineTo(1.3*x2, 1.3*y3);
    path.lineTo(1.3*x1, 1.3*y4);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.black12, 2, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Clipper extends CustomClipper<Path> {
  String view;String side;double width;double height;
  Clipper(this.view,this.side,this.width,this.height);
  @override
  Path getClip(Size size)  {

    double x1,y1,x2,y2,y3,y4,y0,y00,y0O,y00O;
    double inner_baseh=1.8;
    double outer_baseh=1.53;

    //double y0value() {

    //if(view!='Top') {
    //y0 = height/30;
    //y0=width/30;
    y0=80;
    y00=35;
    y0O=57;
    y00O=30;
    // TODO: do operations here
    switch(view){
      case 'Top':
      //y1=30;y2=y1;y3=394;y4=y3;
      //y1=-height/4;y2=y1;y3=height/4;y4=y3;
        x1=-width/3.5;x2=width/3.5;
        y1=-1.29*x1;y2=y1;y3=1.29*x1;y4=y3;
        break;
      case 'Outline':
      //y1=30;y2=y1;y3=394;y4=y3;
      // y1=-height/4;y2=y1;y3=height/4;y4=y3;
        x1=-width/3.5;x2=width/3.5;
        y1=-1.29*x1;y2=y1;y3=1.29*x1;y4=y3;
        break;
      case 'Inner':
      //y1=-height/4-y0value();y2=-height/4+y0value();y3=height/4-y0value();y4=height/4+y0value();
        //x1=-width/5;x2=width/5;
        x1=-width/6;x2=width/6;
        //y1=-1.29*-width/4+y0value();y2=-1.29*-width/4-y0value();y3=1.29*-width/4+y0value();y4=1.29*-width/4-y0value();
        y1=-inner_baseh*-width/4;y2=-inner_baseh*-width/4-y0;y3=inner_baseh*-width/4+y00;y4=inner_baseh*-width/4;
        if(side=='Left'){
          //y1=-height/4+y0value();y2=-height/4-y0value();y3=height/4+y0value();y4=height/4-y0value();
          //x1=-width/5;x2=width/5;
          x1=-width/6;x2=width/6;
          y1=-inner_baseh*-width/4-y0;y2=-inner_baseh*-width/4;y3=inner_baseh*-width/4;y4=inner_baseh*-width/4+y00;
          //y1=-1.29*-width/4-y0value();y2=-1.29*-width/4+y0value();y3=1.29*-width/4-y0value();y4=1.29*-width/4+y0value();
        }
        break;
      case 'Outer':
      //y1=-height/4+y0value();y2=-height/4-y0value();y3=height/4+y0value();y4=height/4-y0value();
        //x1=-width/5;x2=width/5;
        x1=-width/6*1.2;x2=width/6*1.2;
        //y1=-1.29*-width/4-y0value();y2=-1.29*-width/4+y0value();y3=1.29*-width/4-y0value();y4=1.29*-width/4+y0value();
        y1=-outer_baseh*-width/4-y0O;y2=-outer_baseh*-width/4;y3=outer_baseh*-width/4;y4=outer_baseh*-width/4+y00O;
        if(side=='Left'){
          //y1=-height/4-y0value();y2=-height/4+y0value();y3=height/4-y0value();y4=height/4+y0value();
          //x1=-width/5;x2=width/5;
          x1=-width/6*1.2;x2=width/6*1.2;
          y1=-outer_baseh*-width/4;y2=-outer_baseh*-width/4-y0O;y3=outer_baseh*-width/4+y00O;y4=outer_baseh*-width/4;
          //y1=-1.29*-width/4+y0value();y2=-1.29*-width/4-y0value();y3=1.29*-width/4+y0value();y4=1.29*-width/4-y0value();
        }

    }

    Path path1 = Path();
    path1.moveTo(1.3*x1, 1.3*y1);
    path1.lineTo(1.3*x2,1.3*y2);
    path1.lineTo(1.3*x2, 1.3*y3);
    path1.lineTo(1.3*x1, 1.3*y4);
    path1.close();

    return Path()
    /*..moveTo(1.3*x1, 1.3*y1)
    ..lineTo(1.3*x2,1.3*y2)
    ..lineTo(1.3*x2, 1.3*y3)
    ..lineTo(1.3*x1, 1.3*y4)*/
      ..addPath(path1, Offset(size.width/2, size.height/2))
      ..addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

