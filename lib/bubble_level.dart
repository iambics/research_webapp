import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sensors_plus/sensors_plus.dart';
//import 'package:sensors/sensors.dart';
//import '/camera_plugin.dart';
import '/camera_webplugin.dart';
import '/T4.dart';
import '/slide_transition.dart';
import 'dart:html';
import 'dart:js' as js;
import 'package:js/js.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accelerometer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: bubble_level(view:'Inner',side:'Left'),
    );
  }
}

class bubble_level extends StatefulWidget {
  bubble_level({Key key,@required this.view,@required this.side,this.angle,this.rescan}) : super(key: key);

  final String view, side;
  final bool rescan;
  final double angle;

  @override
  bubble_levelState createState() => bubble_levelState();
}

class bubble_levelState extends State<bubble_level> {
  // color of the circle
  Color color = Colors.greenAccent;
  bool flag;

  // event returned from accelerometer stream
  AccelerometerEvent event;

  // hold a reference to these, so that they can be disposed
  Timer timer;
  StreamSubscription accel;

  // positions and count
  double top = 250;//125;
  double left;
  int count = 0;

  // variables for screen size
  double width;
  double height;

  //offset for 45 deg = 70, for 30 degree 100
  setoffset(String view, String side){
    double offset;
    switch(view){
      case 'Top':offset=0;
      break;
      case 'Inner': if(side=='Right')
        offset=widget.angle; else offset=-widget.angle;
      break;
      case 'Outer':if(side=='Right')
        offset=-widget.angle; else offset=widget.angle;
      break;
      case 'Outline':offset=0;
      break;
    }
    return offset;
  }

  setColor(AccelerometerEvent event) {
    // Calculate Left
    double x = ((event.x * 12) + ((width - 100) / 2))-setoffset(widget.view,widget.side);
    // Calculate Top
    double y = event.y * 12 + 500;

    // find the difference from the target position
    var xDiff = x.abs() - ((width -100) / 2);
    var yDiff = y.abs() - 500;

    // check if the circle is centered, currently allowing a buffer of 3 to make centering easier
    if (xDiff.abs() <7 && yDiff.abs() <10) {
      // set the color and increment count
      //original was 8 instead of 2
      setState(() {
        color = Colors.transparent;
        count += 1;
        flag=true;
      });
    } else {
      // set the color and restart count
      setState(() {
        color = Colors.white;
        count = 0;
        flag=false;
      });
    }

  }

  setPosition(AccelerometerEvent event) {
    if (event == null) {
      return;
    }
    height = MediaQuery.of(context).size.height;
    // When x = 0 it should be centered horizontally
    // The left position should equal (width - 100) / 2
    // The greatest absolute value of x is 10, multiplying it by 12 allows the left position to move a total of 120 in either direction.
    setState(() {

      left = ((event.x * 12) + ((width - 48) / 2))-setoffset(widget.view,widget.side);

    });

    // When y = 0 it should have a top position matching the target, which we set at 125
    setState(() {
      top = event.y * 12 + height/2+10;
    });
  }


  startTimer() {
    // if the accelerometer subscription hasn't been created, go ahead and create it
    //js.context.callMethod('getAccel');
    if (accel == null) {
      accel = accelerometerEvents.listen((AccelerometerEvent eve) {
        setState(() {
          event = eve;
        });
      });
    } else {
      // it has already ben created so just resume it
      accel.resume();
    }

    // Accelerometer events come faster than we need them so a timer is used to only proccess them every 100 milliseconds
    if (timer == null || !timer.isActive) {
      timer = Timer.periodic(Duration(milliseconds: 1), (_) {
        // if count has increased greater than 3 call pause timer to handle success
        // proccess the current event
        setColor(event);
        setPosition(event);
        //return color;
      });
    }
  }



  @override
  void dispose() {
    timer?.cancel();
    accel?.cancel();
    super.dispose();
  }

  /*Future<Widget> _initCameraPreview() async {
    return CameraScreen(flag:flag,view: widget.view,side: widget.side,txt: 'generic',);
  }*/

  static const appleType = "apple";
  static const androidType = "android";
  static const desktopType = "desktop";

  String getSmartPhoneOrTablet() {
    final userAgent = window.navigator.userAgent.toString().toLowerCase();
    // smartphone
    if( userAgent.contains("iphone"))  return appleType;
    if( userAgent.contains("android"))  return androidType;

    // tablet
    if( userAgent.contains("ipad")) return appleType;
    if( window.navigator.platform.toLowerCase().contains("macintel") && window.navigator.maxTouchPoints > 0 ) return appleType;

    return desktopType;
  }

  @override
  Widget build(BuildContext context) {
    // get the width and height of the screen
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    if (getSmartPhoneOrTablet()!='android')
        flag=true;
    try {
      startTimer();
    }catch(e){

    }
    return Scaffold(
      //appBar: AppBar(
      //title: Text(widget.title),
      //),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
          ),
          Stack(alignment: Alignment.center,
            children: [
              // This empty container is given a width and height to set the size of the stack
              Container(
                height: height,
                width: width,
              ),
              Positioned.fill(
                child: Opacity(
                    opacity: 1.0,
                    child: Container(
                      //height: 250.0,
                      //color: Colors.lightBlue,
                      child: Center(
                        child: WebCamera(flag,widget.side,widget.view,'generic',widget.rescan)//CameraScreen(flag:flag,view: widget.view,side: widget.side,txt: 'generic'),
                      ),
                    )),
              ),
              // Create the outer target circle wrapped in a Position
              Positioned(top:15,left:width-90,child:IconButton(icon:Icon(Icons.help_outline,color: HexColor('#FFFFFF'),size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => widget.view=='Top'? T5A(widget.side):widget.view=='Inner'?T5B(widget.side):widget.view=='Outer'?T5C(widget.side):T5D(widget.side)),
                    SlideRoute(page: widget.view=='Top'? T5A(widget.side,rescan):widget.view=='Inner'?T5B(widget.side,rescan):widget.view=='Outer'?T5C(widget.side,rescan):null,duration: 600,direction: 'Left'),
                  );
                  //Navigator.of(context).pop();
                },)),
              // This is the colored circle that will be moved by the accelerometer
              // the top and left are variables that will be set
              if (getSmartPhoneOrTablet()=='android')
              Positioned(
                top: top,
                //left: left ?? (width - 48) / 2,
                  left: left ?? (width - 48) / 2,
                // the container has a color and is wrappeed in a ClipOval to make it round or show the tap icon if centered
                child: IgnorePointer(
                    ignoring: true,
                    child:ClipOval(
                         child: flag==true ? Container():
                         Container(
                              width: 48,
                              height: 48,
                              color: color,
                                 ),
                       ))),
              if(flag==true)
                Positioned(bottom:250,
                    child:IgnorePointer(
                        ignoring: true,
                        child:Container(child:Image.asset('assets/images/icon_tap.png', fit: BoxFit.contain)))),
              // inner target circle wrapped in a Position will be rendered transparent if circle is centered
              if (getSmartPhoneOrTablet()=='android')
              Positioned(
                top: height/2,//125,
                //left: (width-70) / 2,
                  left: (width-70) / 2,
                child:  IgnorePointer(
                ignoring: true,
                child:Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    border: flag==true ? Border.all(color: Colors.transparent): Border.all(color: HexColor('FFC40F'), width: 4.0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              )),

              flag==true ?
              Positioned(bottom: 10,//height/6.4,
                              //left: 60/360*width,
                          child:IgnorePointer(
                              ignoring: true,
                              child:Text("Align outline with paper.\nTAP ANYWHERE TO SCAN.",textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              height: 1.5,
                              color: HexColor('#FFFFFF'),
                              fontFamily: 'Barlow',
                              fontWeight: FontWeight.w600),
                        )))
                    : Positioned(
                  bottom: 10,//height/6.4,
                  //left: 100/360*width,
                  child:Text("Tilt your device to center the circle inside\nthe ring until an outline appears.",textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 16.0,
                      height:1.5,
                      color: HexColor('#FFFFFF'),
                      fontFamily: 'Barlow',
                      fontWeight: FontWeight.w600),
                )
              ),

            ],

          ),


        ],
      ),
     );
  }

}

