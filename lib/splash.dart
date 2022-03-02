import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import '/landing_page.dart';
import 'package:splashscreen/splashscreen.dart';
void main() {
  runApp(Splash());
}

class Splash22 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacementNamed(context, '/landing')
        //Navigator.pushReplacement(context,
        //MaterialPageRoute(builder:
        //    (context) =>
        //    Landing_page()//SecondScreen()
        //)
      //)
    );
  }


  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(child:
    //color: Hexcolor('#00CED3'),
     Stack(alignment: Alignment.center,children:[
       Image.asset('assets/images/screen.png', fit: BoxFit.fill, height: double.infinity,
        width: double.infinity,
        ),
      Positioned(top:100, child:FadeIn(
        child: Image.asset('assets/images/logo.png'),
        // Optional paramaters
        duration: Duration(seconds: 3),
        curve: Curves.easeIn,
      )),
    ],
    )
    );
  }
}
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Morteza")),
      body: Center(
          child:Text("Home page",textScaleFactor: 2,)
      ),
    );
  }
}


class Splash2 extends StatefulWidget {
  @override
  _Splash2State createState() => new _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: Landing_page(),
        image: Image.asset('assets/images/screen.png', fit: BoxFit.cover, height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center),
        pageRoute: _createRoute(),
        loaderColor: Colors.transparent,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Welcome In SplashScreen Package"),
          automaticallyImplyLeading: false
      ),
      body: new Center(
        child: new Text("Done!",
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
          ),),

      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Landing_page(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}