import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iambic_research/Z3a-b.dart';
import '/Tutorial.dart';
import '/bubble_level.dart';
import '/foot_survey/S.dart';
import '/slide_transition.dart';
//import 'package:iambic_research/PrimaryButton.dart';
import 'package:video_player/video_player.dart';
//import 'package:lottie/lottie.dart';
import '/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:iambic_research/Z3a-b.dart';
import '/landing_page.dart';
import 'dart:js' as js;
import 'dart:html';
import 'package:google_fonts/google_fonts.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';



//VideoPlayerController _controller;
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
String appleType = "apple";
String androidType = "android";
String desktopType = "desktop";
//bool rescan_flag;

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



class T4 extends StatefulWidget {
  @override
  _T4State createState() => _T4State();
}
class _T4State extends State<T4> with SingleTickerProviderStateMixin {
  String _status1='current';
  String _status2='upcoming';
  String _status3='upcoming';
  String _status4='upcoming';
  //AnimationController _animationController;

  //@override
  //void initState() {
    //super.initState();
    //_animationController =
        //AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
  //}

  //@override
  //void dispose() {
    //super.dispose();
    //_animationController.dispose();
  //}

  setColor(String status){
    Color color;
    switch(status) {
      case 'current':
        return color=HexColor('#BDBDBD').withOpacity(0.5);
      case 'upcoming':
        return color=HexColor('#FFFFFF');
      case 'viewed':
        return color=HexColor('#00CED3').withOpacity(0.2);
    }
  }

  setBorderColor(String status){
  Color color;
  if(status=='viewed') {
    return color = HexColor('#00CED3').withOpacity(0.5);
  }else{
      return color=HexColor('#BDBDBD');
       }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0.5),
                child: Text(
                    "Get Ready To Scan", style: TextStyle(color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#00CED3'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
           ListView(children: [
             //Container(padding: EdgeInsets.fromLTRB(16, 0, 0, 16), alignment:Alignment.center,child:VideoApp('assets/videos/T4.mp4')),
            Container(height: height/2.4,padding: EdgeInsets.all(16), child:Image.asset('assets/images/3_GettingReady.gif')),
            Container(alignment: Alignment.centerLeft,padding: EdgeInsets.fromLTRB(16, 0, 0, 16), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#00CED3'),
                    fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24),
                children: <TextSpan>[
                  TextSpan(text: "Checklist"),
                ],
              ),
            )),
            Container(alignment: Alignment.center,padding: EdgeInsets.fromLTRB(16, 0, 16, 0), child:
            Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start ,children:[
              ClipOval(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: setColor(_status1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(width: 2,color: setBorderColor(_status1),style: BorderStyle.none),
                    ),
                    child: _status1=='viewed' ? Icon(Icons.check, color: HexColor('#00CED3'))
                        : InkWell(
                      child: Icon(Icons.check, color: HexColor('#FFFFFF')),
                      onTap: () {
                        setState(() {
                          _status1 ='viewed';
                          _status2='current';
                          //_animationController.forward();
                        });
                      },
                    ),
                  )),
              Container(alignment: Alignment.center,padding: EdgeInsets.fromLTRB(16, 0, 16, 0), child:
               RichText(
                text: TextSpan(
                  style: TextStyle(color: HexColor('#222222'),
                      fontWeight: FontWeight.w400,
                      height:1.5,
                      fontFamily: 'Barlow',
                      fontSize: 16),
                  children: <TextSpan>[
                      TextSpan(text: "Step 1:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      TextSpan(text: " Stand up. Lay paper on\nthe floor."),
                  ],
                ),
              )),
            ])),
            if(_status1=='viewed')
            Container(alignment: Alignment.center,padding: EdgeInsets.fromLTRB(18,8, 0, 0),child:
            Row(children:[
              ClipOval(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: setColor(_status2),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(width: 2,color: setBorderColor(_status2),style: BorderStyle.none),
                    ),
                    child: _status2=='viewed' ? Icon(Icons.check, color: HexColor('#00CED3'))
                        : InkWell(child:
                      Icon(Icons.check, color: HexColor('#FFFFFF')),
                      onTap: () {
                          if(_status1=='viewed')
                        setState(() {
                          _status2 ='viewed';
                          _status3='current';
                        });
                      },
                    ),
                  )),
              Container(alignment: Alignment.center,padding: EdgeInsets.fromLTRB(16, 0, 16, 0),child:
               RichText(
                text: TextSpan(
                  style: TextStyle(color: HexColor('#222222'),
                      fontWeight: FontWeight.w400,
                      height:1.5,
                      fontFamily: 'Barlow',
                      fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(text: "Step 2:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    TextSpan(text: " Place your entire right\nfoot on the paper."),
                  ],
                ),
              )),
            ])),
           if(_status1=='viewed')
              FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                            height: height-80,
                            decoration: BoxDecoration(
                              color:Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 6,
                                    //offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                                borderRadius: new BorderRadius.only(
                                    topLeft:  const  Radius.circular(10.0),
                                    topRight: const  Radius.circular(10.0))),
                            child:T4D());}
                    ,isScrollControlled:true,);
                },
                child: Container(alignment: Alignment.centerLeft,padding: EdgeInsets.fromLTRB(65, 16, 16, 16),
                    child: Text('Is your foot longer than the paper?', style: new TextStyle(
                        fontSize: 16.0, color: HexColor('#00CED3'))))
            ),
          if(_status2=='viewed')
              Container(alignment: Alignment.center,padding: EdgeInsets.fromLTRB(18, 0, 16, 0),child:
             Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children:[
              ClipOval(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: setColor(_status3),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(width: 2,color: setBorderColor(_status3),style: BorderStyle.none),
                    ),
                    child: _status3=='viewed' ? Icon(Icons.check, color: HexColor('#00CED3'))
                        : InkWell(child:
                      Icon(Icons.check, color: HexColor('#FFFFFF')),
                      onTap: () {
                        if(_status1=='viewed' && _status2=='viewed')
                        setState(() {
                          _status3 ='viewed';
                          _status4='current';
                        });
                      },
                    ),
                  )),
              Container(alignment: Alignment.center,padding: EdgeInsets.fromLTRB(16, 0, 0, 8),child:
               RichText(
                text: TextSpan(
                  style: TextStyle(color: HexColor('#222222'),
                      fontWeight: FontWeight.w400,
                      height:1.5,
                      fontFamily: 'Barlow',
                      fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(text: "Step 3:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    TextSpan(text: " Trace an outline of your\nentire foot. Try to keep your pen\nstraight at a 90° angle with the\npaper while tracing."),
                  ],
                ),
              )),


            ])),
           if(_status3=='viewed')
            Container(alignment: Alignment.center,padding: EdgeInsets.fromLTRB(16, 0, 0, 0),child:
            Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children:[
              ClipOval(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: setColor(_status4),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(width: 2,color: setBorderColor(_status4),style: BorderStyle.none),
                    ),
                    child: _status4=='viewed' ? Icon(Icons.check, color: HexColor('#00CED3'))
                        : InkWell(child:
                    Icon(Icons.check, color: HexColor('#FFFFFF')),
                      onTap: () {
                        if(_status1=='viewed' && _status2=='viewed' &&_status3 =='viewed')
                          setState(() {
                            _status4 ='viewed';
                          });
                      },
                    ),
                  )),
              Container(alignment: Alignment.center,padding: EdgeInsets.fromLTRB(16, 0, 0, 0),child:
               RichText(
                text: TextSpan(
                  style: TextStyle(color: HexColor('#222222'),
                      fontWeight: FontWeight.w400,
                      height:1.5,
                      fontFamily: 'Barlow',
                      fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(text: "Step 4:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    TextSpan(text: " Stand still! Keep your\nfoot on the paper while scanning."),
                  ],
                ),
              )),


            ])),
            //SizedBox(height:25),
            Container(padding:EdgeInsets.fromLTRB(0,16,0,0),alignment: FractionalOffset.bottomRight, child:
            FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => T5A('right')),
                    SlideRoute(page: T5A('Right',false),duration: 300,direction: 'Left'),
                  );
                },
                child: _status1=='viewed' && _status2=='viewed' && _status3=='viewed' && _status4=='viewed'? Text('GOT IT', style: new TextStyle(letterSpacing: 1.5,
                        fontSize: 16.0, color: HexColor('#00CED3'),fontWeight: FontWeight.w700)) : Container(),
            )),
          ]

          )),

    );
    //);
  }
}

class T1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Center(//Align(alignment: Alignment(-0.25, 0.5)
          child:Text("Get Set Up",style: TextStyle(color:HexColor('#222222')),)),
          backgroundColor:HexColor('#A5E0E5'),
          //centerTitle: true,
          /*leading: IconButton(icon:Icon(Icons.arrow_back),color:HexColor('#222222'),
              //onPressed:() => Navigator.pop(context, false),
              onPressed:() => Navigator.pop(context)),*/
          /*actions: <Widget>[
            InkWell(
                onTap: () async{
                  await _firebaseAuth.signOut();
                  //await googleSignIn.signOut();
                  Navigator.push(
                    context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                  );},
                child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                    child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
          ],*/
        ),
        body:
        Column(children:[
          Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              width: double.infinity,
              height:60,
              color:HexColor('#A5E0E5') ,
              child:
              Text("What You'll Need",style:TextStyle(
                  color: HexColor('#222222'),
                  //Colors.grey[800],
                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 32))),
          Expanded(child:RawScrollbar(isAlwaysShown: false,thumbColor: HexColor("#00CED3"),
              child:ListView(
                  children:[
                    menuitem('US Letter Paper', '8.5" X 11", blank, white\npaper', '(no wrinkles!)', 'assets/images/icon_setup1_paper.png',height/170),
                    Divider(color: HexColor('#E0E0E0')),
                    menuitem('Lighting', 'Bright, even lighting', '(no heavy shadows!)','assets/images/icon_setup2_lighting.png',height/170),
                    Divider(color: HexColor('#E0E0E0')),
                    menuitem('Flat Surface', 'Hard, dark floor', '(no carpet!)', 'assets/images/icon_setup3_surface.png',height/170),
                    Divider(color: HexColor('#E0E0E0')),
                    menuitem('Bare feet & ankles', 'Roll up clothing above your ankles', '(no socks!)', 'assets/images/icon_setup4_barefeet.png',height/170),
                    Divider(color: HexColor('#E0E0E0')),
                    /*InkWell(onTap: () {showModalBottomSheet<void>(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                          //height: height-80,
                            decoration: BoxDecoration(
                                color:Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 6,
                                    //offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                                borderRadius: new BorderRadius.only(
                                    topLeft:  const  Radius.circular(0.0),
                                    topRight: const  Radius.circular(0.0))),
                            child:T1B('left',false,false));}
                      ,isScrollControlled:true,);},child:menuitem('Portrait Mode', 'Lock for the best scan experience', '(instructions)', 'assets/images/Icon_Lock.png',height/170)),*/
                    //menuitem('Pen', 'Ready to make its mark', '(no highlighters!)', 'assets/images/Icon_Pen.png',height/170),
                    //Divider(color: HexColor('#E0E0E0')),
                    //menuitem('Tape Measure', 'Flexible, not spring-loaded', '(in centimeters!)', 'assets/images/Icon_Tape.png',height/170),
                  ])
          )),
          SizedBox(height: 16),
          Container(alignment: FractionalOffset.bottomRight, child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
              onPressed: (){
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => T2A()),
                  SlideRoute(page: T1B('Right',false,false),duration: 300,direction: 'Left'),
                );},
              child: Text('GOT IT', style: new TextStyle(letterSpacing: 1.5, fontSize: 16.0, fontWeight: FontWeight.w700, color: HexColor('#00CED3'))))
          )
        ]

        ),
      ),
    );

  }
  Widget menuitem(String txt1, String txt2, String txt3, String imagepath,double padding) {
    return ListTile(
      leading: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100,
          minHeight: 96,
          maxWidth: 100,
          maxHeight: 96,
        ),
        child: Image.asset(
            imagepath, fit: BoxFit.contain),
      ),
      title: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [

        Text(txt1, style:TextStyle(
            color: HexColor('#222222'),//Colors.grey[800],
            fontWeight: FontWeight.w600,
            //fontStyle: FontStyle.italic,
            fontFamily: 'Barlow',
            fontSize: 16)),
        Text(txt2,style:TextStyle(
            color: HexColor('#222222'),//Colors.grey[800],
            fontWeight: FontWeight.w400,
            //fontStyle: FontStyle.italic,
            fontFamily: 'Barlow',
            fontSize: 16)),
        Text(txt3,style:TextStyle(
            color: HexColor('#969696'),//Colors.grey[800],
            fontWeight: FontWeight.w400,
            //fontStyle: FontStyle.italic,
            fontFamily: 'Barlow',
            fontSize: 16)),
      ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: padding,horizontal: 2.0),
    );
  }
}

class T0A extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0),
                child: Text(
                    "Iambic Research", style: TextStyle(fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24, color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFC40F'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                  await _firebaseAuth.signOut();
                  //await googleSignIn.signOut();
                  Navigator.push(
                  context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                  );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                          child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children: [
            Container(
              //padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                width: 300,
                //height: 270,
                child: Image.asset('assets/images/our_science_2.png', fit: BoxFit.fill)),
            Container(width: 360,padding: EdgeInsets.fromLTRB(16, 0,16, 0), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w700,
                    height:1.4,
                    fontFamily: 'Barlow',
                    fontSize: 24),
                children: <TextSpan>[
                  TextSpan(text: "Welcome to  Iambic’s Research App!"),
                  TextSpan(
                      text: "\n\nIambic is building a future where your shoes are a perfect fit and evolve sustainably with you. Your contributions are integral to achieving this mission.\n\nThe Research App will take approx. 15 minutes.",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                ],
              ),
            )),
            //SizedBox(height: 20),
           Expanded(child:Align(alignment: FractionalOffset.bottomRight, child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //await Firebase.initializeApp();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => T0B()),
                    SlideRoute(page: T0C(),duration: 300,direction: 'Left'),
                  );
                },
                child: Padding(padding:EdgeInsets.only(bottom:8),child:Text('NEXT', style: new TextStyle(fontFamily: 'Barlow', letterSpacing: 1.5, fontWeight: FontWeight.w700,
                    fontSize: 16.0, color: HexColor('#00CED3')))))
            ))
          ]

          ),
    );
    //);
  }
}

class T0C extends StatefulWidget {
  T0C({Key key}) : super(key: key);
  @override
  T0CState createState() => new T0CState();
}
class T0CState extends State<T0C> {

  Map<String, bool> values = {
    'I have read the information and agree to participate in this research.': false,
    //'Gender non-conforming': false,
    //'Gender variant': false,
    // 'Intersex': false,
    //'Sign me up for Iambisphere': false,
  };

  var tmpArray = [];
  int count=0;
  bool pass=false;

  getCheckboxItems(){

    values.forEach((key, value) {
      if(value == true)
      {
        //tmpArray.add(key);
        tmpArray.add(value);
      }
    });

    // Printing all selected items on Terminal screen.
    //return pass;

    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () {
          print('Backbutton pressed (device or appbar button), do whatever you want.');

          //trigger leaving and use own data
          Navigator.pop(context, false);

          //we need to return a future
          return Future.value(false);
        },
        child:Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0),
                child: Text(
                    "Iambic Research", style: TextStyle(fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24, color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFC40F'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child:Container(
              padding: EdgeInsets.only(top:16),
                width: 128,
                height: 128,
                child: Image.asset('assets/images/NSF_logo.png', fit: BoxFit.contain))),
            Container(padding: EdgeInsets.fromLTRB(16,16,16,16),child: Text('We are proudly backed by the National Science Foundation. Please read the information sheet  in order to participate.'
                ,style: new TextStyle(fontWeight: FontWeight.w400,fontFamily: 'Barlow',fontSize: 16.0, color: HexColor('#222222'),height:1.5))),
            /*TextButton(
                onPressed: () {
                  // ignore: undefined_prefixed_name
                  ui.platformViewRegistry.registerViewFactory(
                      'sweepstakesrules',
                          (int viewId) => IFrameElement()
                        ..width = '640'
                        ..height = '360'
                        ..src = 'https://www.youtube.com/embed/iYDj8ySBWkA'
                        ..style.border = 'none');

                  showModalBottomSheet<void>(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                        height: height-80,
                        decoration: BoxDecoration(
                            color:Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                //offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                            borderRadius: new BorderRadius.only(
                                topLeft:  const  Radius.circular(10.0),
                                topRight: const  Radius.circular(10.0))),
                        child:null);}
                  ,isScrollControlled:true,);},
                child: Container(padding: EdgeInsets.fromLTRB(8, 0, 16, 16), child:Text('View Sweepstakes Rules', style: new TextStyle(decoration: TextDecoration.underline,
                    fontSize: 16.0, color: HexColor('#00CED3'))))
            ),*/
            Container(padding: EdgeInsets.fromLTRB(16, 0, 16, 16), child:RichText(
              text: TextSpan(
                style: new TextStyle(fontFamily: 'Barlow', fontWeight: FontWeight.w600, decoration: TextDecoration.underline,
                    fontSize: 16.0, color: HexColor('#00CED3')),
                children: <TextSpan>[
                  TextSpan(text: 'View Research Information', style: TextStyle(fontWeight:FontWeight.w500),recognizer: new TapGestureRecognizer()
                    ..onTap = () { launch('https://iambic.co/policies/irb');}),
                ],
              ),
            )),
            Column(mainAxisSize: MainAxisSize.min, children: values.keys.map((String key) {
              return SizedBox(
                  height: 48.0,child: CheckboxListTile(
                title: Text(key,style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height:1.4,
                    fontFamily: 'Barlow',
                    fontSize: 16),),
                value: values[key],
                activeColor: HexColor('#00CED3'),
                checkColor: Colors.white,
                onChanged: (bool value) {
                  setState(() {
                    values[key] = value;
                    pass=value;
                    print(pass);
                  });
                },
              ));
            }).toList(),
            ),
            if(pass)
              Expanded(child:Align(alignment: FractionalOffset.bottomRight, child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                  onPressed: () async {
                    //_controller.dispose();
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => T2B()),
                      SlideRoute(page: T0B(),duration: 300,direction: 'Left'),
                    );
                  },
                  child: Text('NEXT', style: new TextStyle(letterSpacing: 1.5, fontFamily: 'Barlow', fontWeight: FontWeight.w700,
                      fontSize: 16.0, color: HexColor('#00CED3'))))
              ))
          ]
          ),
        )

    );
    //);
  }
}

class T0B extends StatefulWidget {
  T0B({Key key}) : super(key: key);
  @override
  T0BState createState() => new T0BState();
}
class T0BState extends State<T0B> {

  Map<String, bool> values = {
    'I have reviewed, accepted, and agreed to all of the Official Rules.': false,
    //'Gender non-conforming': false,
    //'Gender variant': false,
    // 'Intersex': false,
    //'Sign me up for Iambisphere': false,
  };

  var tmpArray = [];
  int count=0;
  bool pass=false;

  getCheckboxItems(){

    values.forEach((key, value) {
      if(value == true)
      {
        //tmpArray.add(key);
        tmpArray.add(value);
      }
    });

    // Printing all selected items on Terminal screen.
    //return pass;

    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () {
      print('Backbutton pressed (device or appbar button), do whatever you want.');

      //trigger leaving and use own data
      Navigator.pop(context, false);

      //we need to return a future
      return Future.value(false);
    },
    child:Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0),
                child: Text(
                    "Iambic Research", style: TextStyle(fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24, color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFC40F'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: EdgeInsets.fromLTRB(16,32,32,16), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height:1.5,
                    fontFamily: 'Barlow',
                    fontSize: 20),
                children: <TextSpan>[
                  TextSpan(text: "Bespoke Sneaker Sweepstakes"),
                  //TextSpan(
                      //text: " This will help Iambic pair everyone with their perfect fit.",
                      //style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                ],
              ),
            )),
            //SizedBox(height:10),
            /*FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor:HexColor('#FFC40F'),
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                            height: height-80,
                            decoration: BoxDecoration(
                                color:Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 6,
                                    //offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                                borderRadius: new BorderRadius.only(
                                    topLeft:  const  Radius.circular(10.0),
                                    topRight: const  Radius.circular(10.0))),
                            child:T0M());}
                      ,isScrollControlled:true,);

                ;},
                child: Container(padding: EdgeInsets.only(left:12.0),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children:[
                      Icon(Icons.help_outline,color:HexColor('#00CED3'),size:50),
                      Text(' What if I’ve previously taken\n the Iambic Foot Survey?',
                        style: new TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Barlow',fontSize: 16.0, color: HexColor('#00CED3'),height:1.5))
                    ]))
            ),
            SizedBox(height: 20),*/
            Center(child:Container(
              //padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                width: 152,
                height: 100,
                child: Image.asset('assets/images/T0B_Cinderella.png', fit: BoxFit.contain))),
            Container(padding: EdgeInsets.fromLTRB(16,16,16,16),child: Text('We are making custom-fitted sneakers for 50 lucky participants. To enter, answer our survey questions and submit a set of scans through the Iambic Research App.\n\nSubmissions will be reviewed by our team for completion before your entry is counted.'
            ,style: new TextStyle(fontWeight: FontWeight.w400,fontFamily: 'Barlow',fontSize: 16.0, color: HexColor('#222222'),height:1.5))),
            /*TextButton(
                onPressed: () {
                  // ignore: undefined_prefixed_name
                  ui.platformViewRegistry.registerViewFactory(
                      'sweepstakesrules',
                          (int viewId) => IFrameElement()
                        ..width = '640'
                        ..height = '360'
                        ..src = 'https://www.youtube.com/embed/iYDj8ySBWkA'
                        ..style.border = 'none');

                  showModalBottomSheet<void>(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                        height: height-80,
                        decoration: BoxDecoration(
                            color:Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                //offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                            borderRadius: new BorderRadius.only(
                                topLeft:  const  Radius.circular(10.0),
                                topRight: const  Radius.circular(10.0))),
                        child:null);}
                  ,isScrollControlled:true,);},
                child: Container(padding: EdgeInsets.fromLTRB(8, 0, 16, 16), child:Text('View Sweepstakes Rules', style: new TextStyle(decoration: TextDecoration.underline,
                    fontSize: 16.0, color: HexColor('#00CED3'))))
            ),*/
            Container(padding: EdgeInsets.fromLTRB(16, 0, 16, 16), child:RichText(
              text: TextSpan(
                style: new TextStyle(fontFamily: 'Barlow', fontWeight: FontWeight.w600, decoration: TextDecoration.underline,
                    fontSize: 16.0, color: HexColor('#00CED3')),
                children: <TextSpan>[
                  TextSpan(text: 'View Sweepstakes Rules', style: TextStyle(fontWeight:FontWeight.w500),recognizer: new TapGestureRecognizer()
                    ..onTap = () { launch('https://www.iambic.co/policies/sweepstakesrules');}),
                ],
              ),
            )),
            Column(mainAxisSize: MainAxisSize.min, children: values.keys.map((String key) {
              return SizedBox(
                  height: 48.0,child: CheckboxListTile(
                title: Text(key,style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height:1.4,
                    fontFamily: 'Barlow',
                    fontSize: 16),),
                value: values[key],
                activeColor: HexColor('#00CED3'),
                checkColor: Colors.white,
                onChanged: (bool value) {
                  setState(() {
                    values[key] = value;
                    pass=value;
                    print(pass);
                  });
                },
              ));
            }).toList(),
            ),
            if(pass)
            Expanded(child:Align(alignment: FractionalOffset.bottomRight, child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () async {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => T2B()),
                    SlideRoute(page: EmailLog(),duration: 300,direction: 'Left'),
                  );
                },
                child: Text('NEXT', style: new TextStyle(letterSpacing: 1.5, fontFamily: 'Barlow', fontWeight: FontWeight.w700,
                    fontSize: 16.0, color: HexColor('#00CED3'))))
            ))
          ]
          ),
       )

    );
    //);
  }
}

class T0M extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
            InkWell(child:Container(alignment: Alignment.center, child:Column(children:[
              Icon(Icons.keyboard_arrow_down,color: HexColor('#828282'),),
              Text("Close",style: TextStyle(color: HexColor('#828282'),
                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16)),
            ])), onTap: () {Navigator.pop(context);},
            ),
            Container(width: double.infinity, padding: EdgeInsets.fromLTRB(16, 16, 16, 0), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    fontFamily: 'Barlow',
                    fontSize: 24),
                children: <TextSpan>[
                  TextSpan(text: "If you’ve previously taken  the Iambic Foot Survey:\n"),
                  TextSpan(text: '\nYou will only have to capture image scans of your feet and outlines, and will not take video scans or answer background questions.\n\nWhen you previously completed the Iambic Foot Survey, an Iambic team member issued you a',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                  TextSpan(text: " 6-character unique ID",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  TextSpan(text: ' to complete it.\n\nWe’ll prompt you on when and where to enter that ID. If you don’t have it on hand, your Iambic point-of-contact can help you retrieve it.',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                  TextSpan(text: "\n\nThank you for your continued support!",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ],
              ),
            )),

          ]

          );
    //);
  }
}

class T2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0),
                child: Text(
                    "Get Set Up", style: TextStyle(fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24, color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children: [
            Container(
                //padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                width: 360,
                height: 358.2,
                child: Image.asset('assets/images/T2A_Trace.png', fit: BoxFit.fill)),
            Container(padding: EdgeInsets.fromLTRB(16, 8, 8, 16), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height:0.7,
                    fontFamily: 'Barlow',
                    fontSize: 32),
                children: <TextSpan>[
                  TextSpan(text: "What You'll Do"),
                  TextSpan(
                      text: '\nWe’ll be taking 3 captures of each foot at\ndifferent angles:',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,height:1.5)),
                  TextSpan(text: " top, inner, outer.",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,height:1.5)),
                  TextSpan(text: '\nWe’ll guide you every step of the way!',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,height: 1.5)),
                ],
              ),
            )),
            //SizedBox(height: 20),
           Align(alignment: FractionalOffset.bottomRight, child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => T0B()),
                    SlideRoute(page: TutorialList2(arg1: 'viewed',arg2: 'current',arg3: 'upcoming'),duration: 300,direction: 'Left'),
                  );
                },
                 child: Text('GOT IT', style: new TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 16.0, color: HexColor('#00CED3'))))
            )
          ]

          )),

    );
    //);
  }
}

class T2A extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double ratio=height/width/1.5;
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0),
                child: Text(
                    "Get Set Up", style: TextStyle(fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24, color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children: [
            //VideoApp('assets/videos/T2A.mp4'),
            Container(height: height/2.4,padding: EdgeInsets.all(16), child:Image.asset('assets/images/2_TracingFoot.gif')),
            Container(padding: EdgeInsets.all(16), child:
             Center(child:RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height:0.3,
                    fontFamily: 'Barlow',
                    fontSize: 32),
                children: <TextSpan>[
                  TextSpan(text: "What You'll Do\n"),
                  TextSpan(
                      text: "\n\nFirst, you'll",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,height:1.5)),
                  TextSpan(text: " trace your right foot",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,height:1.5)),
                  TextSpan(text: " on a sheet of paper.\n\nWe'll let you know when and how to begin.",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,height:1.5)),
                ],
              ),
            ))),
            //SizedBox(height: 20),
            Expanded(child:Align(alignment: FractionalOffset.bottomRight, child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => T2B()),
                    SlideRoute(page: T2B(),duration: 300,direction: 'Left'),
                  );
                },
                child: Text('NEXT', style: new TextStyle(fontWeight: FontWeight.w700,
                    fontSize: 16.0, color: HexColor('#00CED3'))))
            ))
          ]

          )),

    );
    //);
  }
}

class T2B extends StatefulWidget {
  @override
  T2BState createState() => T2BState();
}

class T2BState extends State<T2B> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double ratio=height/width/1.5;
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0),
                child: Text(
                    "Get Ready to Scan", style: TextStyle(fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24, color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children: [
            //VideoApp('assets/videos/T2B_T7A.mp4'),
            Container(height: height/2.4,padding: EdgeInsets.all(16), child:Image.asset('assets/images/3_GettingReady.gif')),
            Container(padding: EdgeInsets.fromLTRB(32,0,32,0), child:
             Center(child:RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height:1.5,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  //TextSpan(text: "What You'll Do\n\n"),
                  TextSpan(text: "You’ll scan each foot from",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,height:1.5)),
                  TextSpan(text: " 3 angles,",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,height:1.5)),
                  TextSpan(text: " starting with your",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,height:1.5)),
                  TextSpan(text: " right.",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,height:1.5)),
                  TextSpan(text: " Then you’ll capture video scans of each foot. \n\n",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,height:1.5)),
                  TextSpan(text: "We'll guide you every step of the way!",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 0)),
                ],
              ),
            ))),
            //SizedBox(height: 20),
            Expanded(child:Align(alignment: FractionalOffset.bottomRight, child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => TutorialList2(arg1: 'viewed',arg2: 'current',arg3: 'upcoming')),
                    //SlideRoute(page: TutorialList2(arg1: 'viewed',arg2: 'current',arg3: 'upcoming'),duration: 300,direction: 'Left'),
                    SlideRoute(page: T1(),duration: 300,direction: 'Left'),
                  );
                },
                child: Text('GOT IT', style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700,
                    fontSize: 16.0, color: HexColor('#00CED3'))))
            ))
          ]

          )),

    );
    //);
  }
}

class V2I extends StatefulWidget {
  @override
  V2IState createState() => V2IState();
}

class V2IState extends State<V2I> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double ratio=height/width/1.5;
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0),
                child: Text(
                    "New Scan: Right", style: TextStyle(fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24, color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children: [
            //VideoApp('assets/videos/T2B_T7A.mp4'),
            Container(height: height/2.4,padding: EdgeInsets.all(16), child:Image.asset('assets/images/1_SnappingPictures.gif')),
            Container(padding: EdgeInsets.fromLTRB(32,0,32,0), child:
            Center(child:RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height:1.5,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  //TextSpan(text: "What You'll Do\n\n"),
                  TextSpan(text: "This time, ",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,height:1.5)),
                  TextSpan(text: "you’ll take pictures and video of your right foot first. Then you’ll do your left.\n\nFor help: tap the question mark icon.",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,height:1.5)),
                ],
              ),
            ))),
            //SizedBox(height: 20),
            Expanded(child:Align(alignment: FractionalOffset.bottomRight, child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => TutorialList2(arg1: 'viewed',arg2: 'current',arg3: 'upcoming')),
                    //SlideRoute(page: TutorialList2(arg1: 'viewed',arg2: 'current',arg3: 'upcoming'),duration: 300,direction: 'Left'),
                    SlideRoute(page: bubble_level(view: 'Top', side: 'Right',rescan: true),duration: 300,direction: 'Left'),
                  );
                },
                child: Text("I'M READY", style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700,
                    fontSize: 16.0, color: HexColor('#00CED3'))))
            ))
          ]

          )),

    );
    //);
  }
}

class T4D extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
            InkWell(child:Container(alignment: Alignment.center, child:Column(children:[
              Icon(Icons.keyboard_arrow_down,color: HexColor('#828282'),),
              Text("Close",style: TextStyle(color: HexColor('#828282'),
                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16)),
            ])), onTap: () {Navigator.pop(context);},
            ),
             Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                //width: 360,
                height: 200,
                child: Image.asset('assets/images/T4D.png', fit: BoxFit.fill)),
             Container(width: double.infinity, padding: EdgeInsets.fromLTRB(32, 16, 0, 0), child:
              RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                    fontFamily: 'Barlow',
                    fontSize: 24),
                children: <TextSpan>[
                  TextSpan(text: "If your foot is longer than  1 sheet:\n"),
                  TextSpan(text: '\nTape 2 sheets together so your toes fit on the 2nd sheet. Line them up evenly so they look like 1 sheet.\nLine the back of your heel against the 1st sheet’s bottom edge.',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,)),
                ],
              ),
            )),

          ]

          );


    //);
  }
}

class T5AM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
            InkWell(child:Container(alignment: Alignment.center, child:Column(children:[
              Icon(Icons.keyboard_arrow_down,color: HexColor('#828282'),),
              Text("Close",style: TextStyle(color: HexColor('#828282'),
                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16)),
            ])), onTap: () {Navigator.pop(context);},
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                width: 360,
                height: 250,
                child: Image.asset('assets/images/T5AM_T7BM.png', fit: BoxFit.fill)),
            Container(width: double.infinity, padding: EdgeInsets.fromLTRB(32, 16, 16, 0), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                    fontFamily: 'Barlow',
                    fontSize: 21),
                children: <TextSpan>[
                  TextSpan(text: "If you’re using 2 sheets:\n"),
                  TextSpan(text: '\nAlign paper’s bottom 2 corners with',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,)),
                  TextSpan(text: " outline's",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1,color: Colors.red)),
                  TextSpan(text: ' bottom 2 corners.\n\nPaper can extend past outline’s top edge.',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,)),
                ],
              ),
            )),

          ]

          );

    //);
  }
}

class T4AM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(child:Container(alignment: Alignment.center, child:Column(children:[
        Icon(Icons.keyboard_arrow_down,color: HexColor('#828282'),),
        Text("Close",style: TextStyle(color: HexColor('#828282'),
            fontWeight: FontWeight.w600,
            //fontStyle: FontStyle.italic,
            fontFamily: 'Barlow',
            fontSize: 16)),
      ])), onTap: () {Navigator.pop(context);},
      ),
      Container(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          //width: 360,
          height: 200,
          child: Image.asset('assets/images/2_TwoSheetsSetup.gif', fit: BoxFit.fill)),
      Container(width: double.infinity, padding: EdgeInsets.fromLTRB(32, 16, 16, 0), child:
      RichText(
        text: TextSpan(
          style: TextStyle(color: HexColor('#222222'),
              fontWeight: FontWeight.w600,
              height: 1.0,
              fontFamily: 'Barlow',
              fontSize: 21),
          children: <TextSpan>[
            TextSpan(text: "If your foot is longer than  1 sheet:\n"),
            TextSpan(text: '\nAlign 2 sheets together so your toes fit on the 2nd sheet. Line them up evenly so they look like 1 sheet.\n\nLine the back of your heel against the 1st sheet’s bottom edge.',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,)),
          ],
        ),
      )),

    ]

    );

    //);
  }
}

class T4A extends StatelessWidget {
  final String side;
  T4A(this.side);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {

        return true;
      },
      child:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0.5),
                child: Text(
                    "Get Ready to Scan", style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    fontFamily: 'Barlow',
                    fontSize: 24))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children: [
            //VideoApp('assets/videos/T5A_T7B.mp4'),
            Container(height: height/2.6,padding: EdgeInsets.all(0), child: Image.asset('assets/images/HeelAlignment.gif')),
            //Container(height: height/2.4,padding: EdgeInsets.all(16), child:VideoPlayerScreen(filepath:'gs://iambic-v1.appspot.com/Tutorial_videos/T5A_T7B.mp4')),
            Container(width: 360, padding: EdgeInsets.fromLTRB(32, 0, 32, 0), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    fontFamily: 'Barlow',
                    fontSize: 24),
                children: <InlineSpan>[
                  TextSpan(text: "Set Up: Right Foot\n"),
                  WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: SizedBox(height: 30)),
                  TextSpan(text: "•  Stand on paper. Align your heel with the bottom edge. ",style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.2)),

                ],
              ),
            )),
            TextButton(
                onPressed: () {showModalBottomSheet<void>(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                        height: height-80,
                        decoration: BoxDecoration(
                            color:Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                //offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                            borderRadius: new BorderRadius.only(
                                topLeft:  const  Radius.circular(10.0),
                                topRight: const  Radius.circular(10.0))),
                        child:T4AM());}
                  ,isScrollControlled:true,);},
                child: Container(width: 360, padding: EdgeInsets.fromLTRB(32, 8, 32, 0), child:Text('Is your foot longer than the paper?', style: new TextStyle(decoration: TextDecoration.underline,
                    fontSize: 16.0, color: HexColor('#00CED3'))))
            ),
            Container(width: 360, padding: EdgeInsets.fromLTRB(32, 8, 0, 0), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <InlineSpan>[
                  TextSpan(text: "•  Hold device"),
                  TextSpan(text: " over your right foot ",style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: "to align outline with paper.\n"),
                  WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: SizedBox(height: 30)),
                  TextSpan(text: "•  For help: tap the question mark icon."),
                ],
              ),
            )),
            //SizedBox(height:16),
            Expanded(child:Align(alignment: FractionalOffset.bottomRight,
                child:
                FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                  onPressed: () {
                    //_controller.dispose()
                    //js.context.callMethod("getAccel");
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => bubble_level(view:'Top',side:'Right')),
                      //SlideRoute(page: bubble_level(view:'Top',side:side),duration: 300,direction: 'Left'),
                      SlideRoute(page: T5A('Right',false),duration: 300,direction: 'Left'),
                    );
                  },
                  child:Text("GOT IT", style: new TextStyle(letterSpacing: 1.5,
                      fontSize: 16.0, color: HexColor('#00CED3'),fontWeight: FontWeight.w700)),
                ))),
          ]

          )),

    );
    //);
  }
}

class T5A extends StatelessWidget {
  final String side;
  final bool rescan;
  T5A(this.side,this.rescan);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {

        return false;
      },
      child:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0.5),
                child: Text(
                    "Tutorial: Top View", style: TextStyle(fontSize: 24,color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children: [
            //VideoApp('assets/videos/T5A_T7B.mp4'),
            Container(height: height/2.4,padding: EdgeInsets.all(16), child: getSmartPhoneOrTablet()=='android' ? Image.asset('assets/images/TopTilt.gif'):Image.asset('assets/images/iOS_3_Top.gif')),
            //Container(height: height/2.4,padding: EdgeInsets.all(16), child:VideoPlayerScreen(filepath:'gs://iambic-v1.appspot.com/Tutorial_videos/T5A_T7B.mp4')),
            Container(width: 360, padding: EdgeInsets.fromLTRB(32, 16, 32, 0), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  TextSpan(text: "• Hold your device "),
                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: 'over your $side foot.'.toLowerCase(),
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.5)),
                  if(getSmartPhoneOrTablet()!='android')
                    TextSpan(text: 'over your $side foot '.toLowerCase(),
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.5)),
                  if(getSmartPhoneOrTablet()!='android')
                  TextSpan(text: " to align outline with paper."),

                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: "\n\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: "• Tilt",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: " device to center the circle inside the ring until an outline appears."),

                  //TextSpan(text: "\n\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  //TextSpan(text: "Align",style: TextStyle(fontWeight: FontWeight.w600)),
                  //TextSpan(text: " the paper with the outline."),
                  TextSpan(text: "\n\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  if(getSmartPhoneOrTablet()!='android')
                  TextSpan(text: "• Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()!='android')
                  TextSpan(text: " anywhere to scan."),
                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: "• Align",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: " outline with paper and "),
                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: "Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: " to scan."),

                ],
              ),
            )),
            TextButton(
                onPressed: () {showModalBottomSheet<void>(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                        height: height-80,
                        decoration: BoxDecoration(
                            color:Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                //offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                            borderRadius: new BorderRadius.only(
                                topLeft:  const  Radius.circular(10.0),
                                topRight: const  Radius.circular(10.0))),
                        child:T5AM());}
                  ,isScrollControlled:true,);},
                child: Container(width: 360, padding: EdgeInsets.fromLTRB(32, 8, 32, 0), child:Text('Are you using two sheets of paper?', style: new TextStyle(decoration: TextDecoration.underline,
                        fontFamily: 'Barlow', fontSize: 16.0, fontWeight: FontWeight.w600, color: HexColor('#00CED3'))))
            ),
            /*Container(width: 360, padding: EdgeInsets.fromLTRB(32, 8, 0, 0), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 0.5,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  TextSpan(text: "• Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " anywhere to scan."),
                ],
              ),
            )),*/
            //SizedBox(height:16),
             Expanded(child:Align(alignment: FractionalOffset.bottomRight,
                child:
              FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose()
                  //js.context.callMethod("getAccel");
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => bubble_level(view:'Top',side:'Right')),
                    SlideRoute(page: bubble_level(view:'Top',side:side,rescan: rescan),duration: 300,direction: 'Left'),
                  );
                },
                child:Text("GOT IT", style: new TextStyle(letterSpacing: 1.5,
                      fontSize: 16.0, color: HexColor('#00CED3'),fontWeight: FontWeight.w700)),
                ))),
          ]

          )),

    );
    //);
  }
}

class T5BM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
            InkWell(child:Container(alignment: Alignment.center, child:Column(children:[
              Icon(Icons.keyboard_arrow_down,color: HexColor('#828282'),),
              Text("Close",style: TextStyle(color: HexColor('#828282'),
                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16)),
            ])), onTap: () {Navigator.pop(context);},
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                width: 360,
                height: 250,
                child: Image.asset('assets/images/T5BM.png', fit: BoxFit.fill)),
            Container(width: double.infinity, padding: EdgeInsets.fromLTRB(32, 16, 16, 0), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                    fontFamily: 'Barlow',
                    fontSize: 24),
                children: <TextSpan>[
                  TextSpan(text: "If you’re using 2 sheets:\n"),
                  TextSpan(text: '\nAlign paper’s bottom 2 corners with',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,)),
                  TextSpan(text: " outline's ",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,color: Colors.red)),
                  TextSpan(text: "bottom 2 corners.\n\nPaper can extend past outline's top edge.",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,)),
                ],
              ),
            )),

          ]

          );
    //);
  }
}

class T5B extends StatelessWidget {
  final String side;
  final bool rescan;
  T5B(this.side,this.rescan);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String x=side=='Right'? 'left':'right';
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.5, 0.5),
                child: Text(
                    "Tutorial: Inner View", style: TextStyle(fontSize: 24,color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
           /* leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            //VideoApp('assets/videos/T5B_T7C.mp4'),
            getSmartPhoneOrTablet()=='android' ? Container(height: height/2.4,padding: EdgeInsets.all(16), child:side=='Right'?Image.asset('assets/images/6_Side-Tilt.gif'):Image.asset('assets/images/5_Side-Tilt.gif')):
            Container(height: height/2.4,padding: EdgeInsets.all(16), child:side=='Right'?Image.asset('assets/images/iOS_4_InnerR.gif'):Image.asset('assets/images/iOS_4_InnerL.gif')),
            Container(width: 360, padding: EdgeInsets.fromLTRB(32, 0, 32, 8), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  TextSpan(text: "• Hold device over "),
                  TextSpan(text: "$side foot's $x side".toLowerCase(),
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.2)),
                  //TextSpan(text: " to capture an inner view."),

                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: "\n\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: "• Tilt",style: TextStyle(fontWeight: FontWeight.w600)),
                  getSmartPhoneOrTablet()=='android'?
                  TextSpan(text: " device 30° to center the circle inside the ring until an outline appears."):
                  TextSpan(text: " device 30° to align outline with paper."),

                  TextSpan(text: "\n\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  if(getSmartPhoneOrTablet()!='android')
                    TextSpan(text: "• Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()!='android')
                    TextSpan(text: " anywhere to scan."),
                  if(getSmartPhoneOrTablet()=='android')
                    TextSpan(text: "• Align",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()=='android')
                    TextSpan(text: " outline with paper and "),
                  if(getSmartPhoneOrTablet()=='android')
                    TextSpan(text: "Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()=='android')
                    TextSpan(text: " to scan."),
                ],
              ),
            )),
                Container(width:360,child:TextButton(
                onPressed: () {showModalBottomSheet<void>(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                        height: height-80,
                        decoration: BoxDecoration(
                            color:Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                //offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                            borderRadius: new BorderRadius.only(
                                topLeft:  const  Radius.circular(10.0),
                                topRight: const  Radius.circular(10.0))),
                        child:T5BM());}
                  ,isScrollControlled:true,);},
                    child: Container(padding: EdgeInsets.fromLTRB(28, 0, 0, 0), alignment:Alignment.centerLeft,child:Text('Are you using 2 sheets of paper?', style: new TextStyle(decoration: TextDecoration.underline,
                        fontSize: 16.0, color: HexColor('#00CED3'))))
            )),
            /*Container(width: 360, padding: EdgeInsets.fromLTRB(32, 0, 0, 0), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 0.7,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  TextSpan(text: "Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " anywhere to scan."),
                ],
              ),
            )),*/
            //SizedBox(height:16),
            Expanded(child:Align(alignment: FractionalOffset.bottomRight,
                child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => bubble_level(view:'Inner', side:'Right')),
                    SlideRoute(page: bubble_level(view:'Inner', side:side,angle:100,rescan: rescan),duration: 300,direction: 'Left'),
                  );
                },
                  child: Text("GOT IT", style: new TextStyle(letterSpacing: 1.5,
                      fontSize: 16.0, color: HexColor('#00CED3'),fontWeight: FontWeight.w700)),
                ))),
          ]

          )),

    );
    //);
  }
}

class T5CM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
            InkWell(child:Container(alignment: Alignment.center, child:Column(children:[
              Icon(Icons.keyboard_arrow_down,color: HexColor('#828282'),),
              Text("Close",style: TextStyle(color: HexColor('#828282'),
                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16)),
            ])), onTap: () {Navigator.pop(context);},
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                width: 360,
                height: 250,
                child: Image.asset('assets/images/T5CM.png', fit: BoxFit.fill)),
            Container(width: double.infinity, padding: EdgeInsets.fromLTRB(32, 16, 16, 0), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                    fontFamily: 'Barlow',
                    fontSize: 24),
                children: <TextSpan>[
                  TextSpan(text: "If you’re using 2 sheets:\n"),
                  TextSpan(text: '\nAlign paper’s bottom 2 corners with',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,)),
                  TextSpan(text: " outline's",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,color: Colors.red)),
                  TextSpan(text: " bottom 2 corners.\n\nPaper can extend past outline's top edge",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,)),
                ],
              ),
            )),

          ]

          );
    //);
  }
}

class T5C extends StatelessWidget {
  final String side;
  final bool rescan;
  T5C(this.side,this.rescan);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String x=side=='Right'? 'right':'left';
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.5, 0.5),
                child: Text(
                    "Tutorial: Outer View", style: TextStyle(fontSize: 24,color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
            //VideoApp('assets/videos/T5C_T7D.mp4'),
            getSmartPhoneOrTablet()=='android' ? Container(height: height/2.4,padding: EdgeInsets.all(16), child: side=='Right'? Image.asset('assets/images/5_Side-Tilt.gif'):Image.asset('assets/images/6_Side-Tilt.gif')):
            Container(height: height/2.4,padding: EdgeInsets.all(16), child:side=='Right'?Image.asset('assets/images/iOS_5_OuterR.gif'):Image.asset('assets/images/iOS_5_OuterL.gif')),
            Container(width: 360, padding: EdgeInsets.fromLTRB(32, 16, 32, 0), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  TextSpan(text: "• Hold device over "),
                  TextSpan(text: "$side foot's $x side".toLowerCase(),
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.5)),
                  //TextSpan(text: " to capture an inner view."),

                  if(getSmartPhoneOrTablet()=='android')
                    TextSpan(text: "\n\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  if(getSmartPhoneOrTablet()=='android')
                    TextSpan(text: "• Tilt",style: TextStyle(fontWeight: FontWeight.w600)),
                  getSmartPhoneOrTablet()=='android'?
                  TextSpan(text: " device 45° to center the circle inside the ring until an outline appears."):
                  TextSpan(text: " device 45° to align outline with paper."),

                  TextSpan(text: "\n\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  if(getSmartPhoneOrTablet()!='android')
                    TextSpan(text: "• Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()!='android')
                    TextSpan(text: " anywhere to scan."),
                  if(getSmartPhoneOrTablet()=='android')
                    TextSpan(text: "• Align",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()=='android')
                    TextSpan(text: " outline with paper and "),
                  if(getSmartPhoneOrTablet()=='android')
                    TextSpan(text: "Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()=='android')
                    TextSpan(text: " to scan."),
                ],
              ),
            )),
            FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {showModalBottomSheet<void>(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                        height: height-80,
                        decoration: BoxDecoration(
                            color:Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                //offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                            borderRadius: new BorderRadius.only(
                                topLeft:  const  Radius.circular(10.0),
                                topRight: const  Radius.circular(10.0))),
                        child:T5CM());}
                  ,isScrollControlled:true,);},
                child: Container(padding: EdgeInsets.fromLTRB(38, 0, 0, 0), alignment:Alignment.centerLeft,
                    child: Text('Are you using 2 sheets of paper?', style: new TextStyle(decoration: TextDecoration.underline,
                        fontSize: 16.0, color: HexColor('#00CED3'))))
            ),
            /*Container(width: double.infinity, padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 0.7,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "\n\n ", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 40)),
                  TextSpan(text: "Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " anywhere to scan."),
                ],
              ),
            )),*/
            //SizedBox(height:16),
            Expanded(child:Align(alignment: FractionalOffset.bottomRight,
                child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => bubble_level(view:'Outer',side:'Right')),
                    SlideRoute(page: bubble_level(view:'Outer',side:side,angle: 70,rescan: rescan,),duration: 300,direction: 'Left'),
                  );
                },
                child: Container(padding:EdgeInsets.only(bottom:16),alignment: Alignment.bottomRight,
                  child: Text("GOT IT", style: new TextStyle(
                      fontSize: 16.0, color: HexColor('#00CED3'))),
                )))),
          ]

          )),

    );
    //);
  }
}

class T5DM extends StatelessWidget {
  final String side;
  T5DM(this.side);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
            InkWell(child:Container(alignment: Alignment.center, child:Column(children:[
              Icon(Icons.keyboard_arrow_down,color: HexColor('#828282'),),
              Text("Close",style: TextStyle(color: HexColor('#828282'),
                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16)),
            ])), onTap: () {Navigator.pop(context);},
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                width: 360,
                height: 250,
                child: Image.asset('assets/images/T5DM.png', fit: BoxFit.fill)),
            Container(width: double.infinity, padding: EdgeInsets.fromLTRB(32, 16, 0, 0), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                    fontFamily: 'Barlow',
                    fontSize: 24),
                children: <TextSpan>[
                  TextSpan(text: "If you’re using two sheets of\npaper:\n"),
                  TextSpan(text: '\nAlign the top two corners of the paper with\nthe top two corners of the',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,)),
                  TextSpan(text: ' outline',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,color: Colors.red)),
                  TextSpan(text: '.\n\nThe paper can extend past the bottom edge\nof the rectangular outline, and that’s okay.',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5,)),
                ],
              ),
            )),

          ]

          );
    //);
  }
}

class T5D extends StatelessWidget {
  final String side;
  T5D(this.side);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.5, 0.5),
                child: Text(
                    "Tutorial: $side Outline", style: TextStyle(fontFamily: 'Barlow', letterSpacing: 1.5, fontSize: 20,color: HexColor('#222222'),fontWeight: FontWeight.w700))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children: [
            Container(height: height/3.4,padding: EdgeInsets.fromLTRB(0,0,0,8), child:getSmartPhoneOrTablet()=='android' ?Image.asset('assets/images/T5D.png'):Image.asset('assets/images/T5D_T7E.png')),
            Container(width: 360, padding: EdgeInsets.fromLTRB(32, 0, 32, 8), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  TextSpan(text: "Remove ",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.2)),
                  TextSpan(text: "your "),
                  TextSpan(text: "$side foot",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.2)),
                  TextSpan(text: " from the sheet of paper.\n\nHold your device over the sheet of paper."),

                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: "\n\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: "Tilt",style: TextStyle(fontWeight: FontWeight.w600)),
                  if(getSmartPhoneOrTablet()=='android')
                  TextSpan(text: " your device to center the circle inside the ring until an outline appears."),

                  TextSpan(text: "\n\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  TextSpan(text: "Align",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " the paper with the outline."),
                  TextSpan(text: "\n\n", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 0)),
                  TextSpan(text: "Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " anywhere to scan."),
                ],
              ),
            )),
                FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {showModalBottomSheet<void>(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                        height: height-80,
                        decoration: BoxDecoration(
                            color:Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                //offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                            borderRadius: new BorderRadius.only(
                                topLeft:  const  Radius.circular(10.0),
                                topRight: const  Radius.circular(10.0))),
                        child:T5DM('$side'));}
                  ,isScrollControlled:true,);},
                    child: Container(width:360,padding: EdgeInsets.fromLTRB(32, 8, 0, 0),alignment: Alignment.centerLeft, child:Text('Are you using 2 sheets of paper?', style: new TextStyle(
                        fontSize: 16.0, color: HexColor('#00CED3'),fontWeight: FontWeight.w600)))
            ),
            /*Container(width: double.infinity, padding: EdgeInsets.fromLTRB(16, 0, 0, 0), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 0.7,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "\n\n ", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 20)),
                  TextSpan(text: "Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " anywhere to take the picture"),
                ],
              ),
            )),*/
            //SizedBox(height:16),
            Expanded(child:Align(alignment: FractionalOffset.bottomRight,
                child:
                FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                  onPressed: () {
                    //_controller.dispose();
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => bubble_level(view:'Outline',side:side)),
                      SlideRoute(page: bubble_level(view:'Outline',side:side),duration: 300,direction: 'Left'),
                    );
                  },
                  child:Padding(padding:EdgeInsets.fromLTRB(16,16,8,16),child:Text("GOT IT", style: new TextStyle(letterSpacing: 1.5,
                      fontSize: 16.0, color: HexColor('#00CED3'),fontWeight: FontWeight.w700))),
                ))),
          ]

          )),

    );
    //);
  }
}

class T7A extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0.5),
                child: Text(
                    "What You'll Do", style: TextStyle(fontSize:24,color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children: [
            //VideoApp('assets/videos/T2B_T7A.mp4'),
            Container(height: height/2.4,padding: EdgeInsets.all(16), child:Image.asset('assets/images/1_SnappingPictures.gif')),
            Container(padding: EdgeInsets.fromLTRB(32.0,0,32,0), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    fontFamily: 'Barlow',
                    fontSize: 24),
                children: <TextSpan>[

                  TextSpan(
                      text: 'You’ll be doing the ',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                  TextSpan(text: "same process",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                  TextSpan(text: ' for your left foot: ',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                  TextSpan(text: "Trace an outline of your left foot. Keep it still",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                  TextSpan(text: ' and in place while tracing and scanning.\n\nIf you need help: tap the',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                  TextSpan(text: " question mark icon",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                  TextSpan(text: ' in the upper right corner.',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),

                ],
              ),
            )),
            //Divider(color: Colors.black),
            //SizedBox(height: 15),
             Expanded(child:Align(alignment: FractionalOffset.bottomRight,
               child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => bubble_level(side:'Left',view:'Top')),
                    SlideRoute(page: bubble_level(side:'Left',view:'Top'),duration: 300,direction: 'Left'),
                  );
                },
                child: Text('GOT IT', style: new TextStyle(letterSpacing: 1.5,
                        fontSize: 18.0, color: HexColor('#00CED3'),fontWeight: FontWeight.w700))
            )))
          ]

          )),

    );
    //);
  }
}

class T7B extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0.5),
                child: Text(
                    "Tutorial: Top View", style: TextStyle(fontSize: 24,color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
           /* actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          ListView(children: [
            Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                width: double.infinity,
                height: 284,
                child: Image.asset('assets/images/bg.png', fit: BoxFit.fill)),
            Container(width: double.infinity, padding: EdgeInsets.fromLTRB(33, 52, 16, 16), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[

                  TextSpan(text: "Place your device "),
                  TextSpan(text: 'directly over your left foot',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.2)),
                  TextSpan(text: " to\n capture a top view scan."),


                  TextSpan(text: "\n\nTilt",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " your device to center the circle inside the\n ring. An onscreen outline will appear."),


                  TextSpan(text: "\n\nAlign",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " the paper with the outline. Then,"),


                  TextSpan(text: " tap\n",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: "anywhere to scan. You've got this!"),
                ],
              ),
            )),
            //SizedBox(height:35),
            FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => bubble_level(side:'Left',view:'Top')),
                    SlideRoute(page: bubble_level(side:'Left',view:'Top'),duration: 300,direction: 'Left'),
                  );
                },
                child: Container(padding: EdgeInsets.fromLTRB(16, 16, 16, 16),alignment: Alignment.bottomRight,
                  child: Text("GOT IT", style: new TextStyle(fontWeight: FontWeight.w700,
                      fontSize: 16.0, color: HexColor('#00CED3'))),
                )),
          ]

          )),

    );
    //);
  }
}

class T7C extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.5, 0.5),
                child: Text(
                    "Tutorial: Inner View", style: TextStyle(fontSize: 24,color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          ListView(children: [
            Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                width: double.infinity,
                height: 284,
                child: Image.asset('assets/images/T7C.png', fit: BoxFit.contain)),
            Container(width: double.infinity, padding: EdgeInsets.fromLTRB(16, 16, 16, 16), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "1", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 40)),
                  TextSpan(text: "Place your device "),
                  TextSpan(text: "directly over your left\n            foot's right side",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.2)),
                  TextSpan(text: " to capture an outer view."),

                  TextSpan(text: "\n\n2", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 40)),
                  TextSpan(text: "Tilt",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " your device to center the circle inside\n             the ring. An onscreen outline will appear."),

                  TextSpan(text: "\n\n3", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 40)),
                  TextSpan(text: "Align",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " the paper with the outline."),

                  TextSpan(text: "\n\n4", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 40)),
                  TextSpan(text: "Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " anywhere to scan."),
                ],
              ),
            )),
            //SizedBox(height:16),
            Align(alignment: FractionalOffset.bottomRight,
                child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => bubble_level(view:'Inner',side:'Left')),
                    SlideRoute(page: bubble_level(view:'Inner',side:'Left'),duration: 300,direction: 'Left'),
                  );
                },
                  child: Text("I'M READY", style: new TextStyle(
                      fontSize: 16.0, color: HexColor('#00CED3'))),
                )),
          ]

          )),

    );
    //);
  }
}

class T7D extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.5, 0.5),
                child: Text(
                    "Tutorial: Outer View", style: TextStyle(fontSize: 24,color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFFFFF'),
            //centerTitle: true,
            /*leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context)),*/
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          ListView(children: [
            Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                width: double.infinity,
                height: 284,
                child: Image.asset('assets/images/T5C.png', fit: BoxFit.fill)),
            Container(width: double.infinity, padding: EdgeInsets.fromLTRB(0, 16, 16, 16), child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "1", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 40)),
                  TextSpan(text: "Place your device "),
                  TextSpan(text: "directly over your left\n            foot's left side",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.2)),
                  TextSpan(text: " to capture an outer view."),

                  TextSpan(text: "\n\n2", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 40)),
                  TextSpan(text: "Tilt",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " your device to center the circle inside\n             the ring. An onscreen outline will appear."),

                  TextSpan(text: "\n\n3", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 40)),
                  TextSpan(text: "Align",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " the paper with the outline."),

                  TextSpan(text: "\n\n4", style: TextStyle(color: HexColor('#BDBDBD'),letterSpacing: 40)),
                  TextSpan(text: "Tap",style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: " anywhere to scan."),
                ],
              ),
            )),
            //SizedBox(height:16),
            FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  //_controller.dispose();
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => bubble_level(side:'Left',view:'Outer')),
                    SlideRoute(page: bubble_level(side:'Left',view:'Outer'),duration: 300,direction: 'Left'),
                  );
                },
                child: Container(padding: EdgeInsets.only(bottom:8),alignment: Alignment.bottomRight,
                  child: Text("I'M READY", style: new TextStyle(
                      fontSize: 16.0, color: HexColor('#00CED3'))),
                )),
          ]

          )),

    );
    //);
  }
}

class VideoApp extends StatefulWidget {
  final String filepath;
  VideoApp(this.filepath);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> with SingleTickerProviderStateMixin{
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.filepath,videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);

        });
      });

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    //_controller.pause();
    debugPrint('CmVideoPlayer - dispose()');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(height:height/2.5,
          child:_controller.value.initialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(color: Colors.white,),
      );

  }
}

class T1B extends StatelessWidget {
  final String side;
  bool rflag,lflag;
  T1B(this.side,this.rflag,this.lflag);
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Center(child:Text("Get Set Up",style: TextStyle(color:HexColor('#222222')),)),
          backgroundColor:HexColor('#A5E0E5'),
          automaticallyImplyLeading: false,
          //centerTitle: true,
          //leading: IconButton(icon:Icon(Icons.arrow_back),color:HexColor('#222222'),
              //onPressed:() => Navigator.pop(context, false),
              //onPressed:() => Navigator.pop(context)),
          /*actions: <Widget>[
            InkWell(
                onTap: () async{
                  await _firebaseAuth.signOut();
                  //await googleSignIn.signOut();
                  Navigator.push(
                    context, SlideRoute(page: Landing_page(),duration: 300,direction: 'Left'),
                  );},
                child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                    child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
          ],*/
        ),
        body:
        Center(child:Container(width:double.infinity,child:
        Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  width: double.infinity,
                  height:60,
                  color:HexColor('#A5E0E5') ,
                  child:
                  Text("Disable Auto-Rotate",style:TextStyle(
                      color: HexColor('#222222'),
                      //Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      //fontStyle: FontStyle.italic,
                      fontFamily: 'Barlow',
                      fontSize: 32))),
              /*InkWell(child:Container(alignment: Alignment.center, child:Column(children:[
                Icon(Icons.keyboard_arrow_down,color: HexColor('#828282'),),
                Text("Close",style: TextStyle(color: HexColor('#828282'),
                    fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 16)),
              ])), onTap: () {Navigator.pop(context);},
              ),*/
              Container(
                  padding: EdgeInsets.fromLTRB(0,24,0,16),
                  height: 100,
                  child: getSmartPhoneOrTablet()=='android' ? Image.asset('assets/images/Icon_Rotate.png', fit: BoxFit.fill):Image.asset('assets/images/Icon_Lock.png', fit: BoxFit.fill)),

              Padding(padding:EdgeInsets.fromLTRB(34, 0, 34, 0),child:Text('Please lock your screen’s Portrait Mode.\n',style: TextStyle(fontFamily: 'Barlow', fontWeight: FontWeight.w400, fontSize: 16.0, color: HexColor('#222222')),textAlign: TextAlign.left)),

              /*Padding(padding:EdgeInsets.fromLTRB(24, 0, 0, 0),child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children:[
                Expanded(child:InkWell(
                    onTap: () {showModalBottomSheet<void>(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                          //height: height-80,
                            decoration: BoxDecoration(
                                color:Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 6,
                                    //offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                                borderRadius: new BorderRadius.only(
                                    topLeft:  const  Radius.circular(0.0),
                                    topRight: const  Radius.circular(0.0))),
                            child:W2XM1());}
                      ,isScrollControlled:true,);},
                    child: Container(width:375,padding: EdgeInsets.fromLTRB(0, 0, 0, 0), alignment:Alignment.centerLeft,
                        child: Text('\niOS Instructions', style:GoogleFonts.jost(fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,textStyle:TextStyle(decoration: TextDecoration.underline, color: HexColor('222222'),letterSpacing: 0,height: 1.4))))
                )),
                //SizedBox(width:34),
                Expanded(child:InkWell(
                    onTap: () {showModalBottomSheet<void>(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                          //height: height-80,
                            decoration: BoxDecoration(
                                color:Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 6,
                                    //offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                                borderRadius: new BorderRadius.only(
                                    topLeft:  const  Radius.circular(0.0),
                                    topRight: const  Radius.circular(0.0))),
                            child:W2XM2());}
                      ,isScrollControlled:true,);},
                    child: Container(width:375,padding: EdgeInsets.fromLTRB(0, 0, 0, 0), alignment:Alignment.centerLeft,
                        child: Text('\nAndroid Instructions', style:GoogleFonts.jost(fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,textStyle:TextStyle(decoration: TextDecoration.underline, color: HexColor('222222'),letterSpacing: 0,height: 1.4))))
                )),
              ])),*/
              Container(padding: EdgeInsets.fromLTRB(34, 0, 34, 0),width:400, child:
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'Barlow',fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#222222')),
                  children: <TextSpan>[
                    TextSpan(text: "Step 1: Swipe"),
                    TextSpan(text: " downward from the device’s upper-right corner to open the Control Center.\n",
                      style:TextStyle(fontFamily: 'Barlow',fontWeight: FontWeight.w400, fontSize: 16.0, color: HexColor('#222222'))),
                  ],
                ),
              )),
            Container(padding: EdgeInsets.fromLTRB(34, 0, 34, 0),width:400, child:getSmartPhoneOrTablet()=='android' ?
            RichText(
              text: TextSpan(
                style: TextStyle(fontFamily: 'Barlow',fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#222222')),
                children: <TextSpan>[
                  TextSpan(text: "Step 2: Tap "),
                  TextSpan(text: 'Auto-Rotate icon (pictured above) to lock device in Portrait mode.\n\n',style:TextStyle(fontFamily: 'Barlow',fontWeight: FontWeight.w400, fontSize: 16.0, color: HexColor('#222222'))),
                  TextSpan(text: "*Some devices may require 2 downward swipes to reveal all quick-toggle icons.", style:TextStyle(fontFamily: 'Barlow',fontWeight: FontWeight.w400, fontSize: 13.0, color: HexColor('#222222'))),
                ],
              ),
            ):
            RichText(
                text:TextSpan(
                    style: TextStyle(fontFamily: 'Barlow',fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#222222')),
                    children: <TextSpan>[
                      TextSpan(text: "Step 2: Tap "),
                      TextSpan(text: 'the Portrait Orientation Lock icon (pictured above) to enable.\n\n',style:TextStyle(fontFamily: 'Barlow',fontWeight: FontWeight.w400, fontSize: 16.0, color: HexColor('#222222'))),
                      TextSpan(text: "*For iPhone SE, iPhone 8 and earlier models, swipe up from the bottom edge of the screen.", style:TextStyle(fontFamily: 'Barlow',fontWeight: FontWeight.w400, fontSize: 13.0, color: HexColor('#222222'))),
                    ]))),
              /*InkWell(
                  onTap: () {showModalBottomSheet<void>(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return Container(
                        //height: height-80,
                          decoration: BoxDecoration(
                              color:Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 6,
                                  //offset: Offset(4, 8), // Shadow position
                                ),
                              ],
                              borderRadius: new BorderRadius.only(
                                  topLeft:  const  Radius.circular(0.0),
                                  topRight: const  Radius.circular(0.0))),
                          child:T1M1());}
                    ,isScrollControlled:true,);},
                  child: Container(width:double.infinity,padding: EdgeInsets.fromLTRB(24, 0, 34, 0), alignment:Alignment.centerLeft,
                      child: Text('\niOS Instructions', style:GoogleFonts.jost(fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,textStyle:TextStyle(decoration: TextDecoration.underline, color: HexColor('#00CED3'),letterSpacing: 0,height: 1.4))))
              ),
              InkWell(
                  onTap: () {showModalBottomSheet<void>(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return Container(
                        //height: height-80,
                          decoration: BoxDecoration(
                              color:Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 6,
                                  //offset: Offset(4, 8), // Shadow position
                                ),
                              ],
                              borderRadius: new BorderRadius.only(
                                  topLeft:  const  Radius.circular(0.0),
                                  topRight: const  Radius.circular(0.0))),
                          child:T1M2());}
                    ,isScrollControlled:true,);},
                  child: Container(width:double.infinity,padding: EdgeInsets.fromLTRB(24, 0, 34, 0), alignment:Alignment.centerLeft,
                      child: Text('\nAndroid Instructions', style:GoogleFonts.jost(fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,textStyle:TextStyle(decoration: TextDecoration.underline, color: HexColor('#00CED3'),letterSpacing: 0,height: 1.4))))
              ),*/

              Expanded(child:Align(alignment: FractionalOffset.bottomRight,
                  child:
                  FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                    onPressed: () {
                      //_controller.dispose()
                      //js.context.callMethod("getAccel");
                      Navigator.push(
                        context,
                        //MaterialPageRoute(builder: (context) => bubble_level(view:'Top',side:'Right')),
                        SlideRoute(page: T4A('Right'),duration: 300,direction: 'Left'),
                      );
                    },
                    child:Text("GOT IT", style: new TextStyle(letterSpacing: 1.5,
                        fontSize: 16.0, color: HexColor('#00CED3'),fontWeight: FontWeight.w600)),
                  ))),
              //SizedBox(height: 34),
            ]
         )))
        );

    //);
  }
}

class T1M1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body:
      Center(child:Container(width:400,child:
      Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        InkWell(child:Container(padding:EdgeInsets.all(16),alignment: Alignment.centerRight, child:Column(children:[
          Icon(Icons.close,color: HexColor('#828282'),),
        ])), onTap: () {Navigator.pop(context);},
        ),
        Container(padding: EdgeInsets.only(top:34),child:Text("PORTRAIT ORIENTATION LOCK: iOS",textAlign: TextAlign.center,style:GoogleFonts.jost(fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 17,textStyle:TextStyle(color: HexColor('222222'),letterSpacing: 1.5,height: 1.4)))),
        Container(height:96,width:96,padding: EdgeInsets.fromLTRB(0,24,0,24), child: Image.asset('assets/images/Icon_Lock.png', fit: BoxFit.scaleDown)),
        Container(padding: EdgeInsets.fromLTRB(34, 0, 34, 0),width:400, child:
        RichText(
          text: TextSpan(
            style:GoogleFonts.jost(fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600, fontSize: 17,
                textStyle:TextStyle(color: HexColor('222222'),letterSpacing: 0,height: 1.4)),
            children: <TextSpan>[
              TextSpan(text: "Step 1: Swipe", style: GoogleFonts.jost(fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600, fontSize: 17)),
              TextSpan(text: " downward from the device’s upper-right corner to open the Control Center.\n",
                  style: GoogleFonts.jost(fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400, fontSize: 17)),
            ],
          ),
        )),
        Container(padding: EdgeInsets.fromLTRB(34, 0, 34, 0),width:400, child:
        RichText(
          text:TextSpan(
              style:GoogleFonts.jost(fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500, fontSize: 17,
                  textStyle:TextStyle(color: HexColor('222222'),letterSpacing: 0,height: 1.4)),
              children: <TextSpan>[
                TextSpan(text: "Step 2: Tap ", style: GoogleFonts.jost(fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600, fontSize: 17)),
                TextSpan(text: 'the Portrait Orientation Lock icon (pictured above) to enable.\n',style: GoogleFonts.jost(fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400, fontSize: 17))]),
        )),
        SizedBox(height:34)
      ]

      ))),

    );
  }
}

class T1M2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body:
      Center(child:Container(width:400,child:
      Column(children: [
        InkWell(child:Container(padding:EdgeInsets.all(16),alignment: Alignment.centerRight, child:Column(children:[
          Icon(Icons.close,color: HexColor('#828282'),),
        ])), onTap: () {Navigator.pop(context);},
        ),
        Container(padding: EdgeInsets.only(top:34),child:Text("PORTRAIT ORIENTATION LOCK: ANDROID",textAlign: TextAlign.center,style:GoogleFonts.jost(fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 17,textStyle:TextStyle(color: HexColor('222222'),letterSpacing: 1.5,height: 1.4)))),
        Container(height:96,width:96,padding: EdgeInsets.fromLTRB(0,24,0,24), child: Image.asset('assets/images/Icon_Rotate.png', fit: BoxFit.scaleDown)),
        Container(padding: EdgeInsets.fromLTRB(34, 0, 34, 0), width:400, child:
        RichText(
          text: TextSpan(
            style:GoogleFonts.jost(fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600, fontSize: 17,
                textStyle:TextStyle(color: HexColor('222222'),letterSpacing: 0,height: 1.4)),
            children: <TextSpan>[
              TextSpan(text: "Step 1: Swipe", style: GoogleFonts.jost(fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600, fontSize: 17)),
              TextSpan(text: " downward from the device’s upper-right corner to open the Control Center.\n",
                  style: GoogleFonts.jost(fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400, fontSize: 17)),
            ],
          ),
        )),
        Container(padding: EdgeInsets.fromLTRB(34, 0, 34, 0),width:400, child:
        RichText(
          text:TextSpan(
              style:GoogleFonts.jost(fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500, fontSize: 17,
                  textStyle:TextStyle(color: HexColor('222222'),letterSpacing: 0,height: 1.4)),
              children: <TextSpan>[
                TextSpan(text: "Step 2: Tap ", style: GoogleFonts.jost(fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600, fontSize: 17)),
                TextSpan(text: 'the Auto-Rotate icon (pictured above) to disable auto-rotate and lock-on Portrait mode.\n',style: GoogleFonts.jost(fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400, fontSize: 17))]),
        )),
        Padding(padding:EdgeInsets.only(left:34),child:Text('*Some devices may require two downward swipes to reveal all quick-toggle icons')),
        SizedBox(height:34)
      ]
      ))),

    );
  }
}


void main() {
  runApp(MaterialApp(
    home: T1()//Container(height: 200,padding: EdgeInsets.all(16), child:VideoApp('assets/videos/T5A_T7B.mp4')),

  ));
}