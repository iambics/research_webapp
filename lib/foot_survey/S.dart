import 'package:iambic_research/bubble_level.dart';
import 'package:iambic_research/camera_webplugin.dart';
import 'package:iambic_research/video_player.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import '/slide_transition.dart';
import '/google_signin.dart';
import '/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'video_capture.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '/Z3a-b.dart';
import '/T4.dart';
import 'package:iambic_research/Z3a-b.dart';
import '/rating_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_web/video_player_web.dart';
import 'video_webcapture.dart';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '/videoweb.dart';

bool trickyfit_checked=true;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //primarySwatch: ,
        unselectedWidgetColor: HexColor('#00CED3'), // <-- your color
      ),
      home: V1E("Left",true),
    );
  }
}
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
class S0 extends StatelessWidget {
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
                    ////await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          ListView(children: [
            Container(padding: EdgeInsets.all(16), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w500,
                    height:1.4,
                    fontFamily: 'Barlow',
                    fontSize: 20),
                children: <TextSpan>[
                  TextSpan(text: "Great, thanks! Your photo scans are now complete.\n\nNext, we have a few demographic questions and video scans.\n"),
                  TextSpan(
                      text: "\nEstimated time remaining: 5-10 minutes\n",
                      style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w400, fontSize: 16)),
               TextSpan(text: "\nFirst, have you previously completed the Iambic Foot Survey?"),
                  TextSpan(
                      text: "\n\nHint: An Iambic team member would have given you a 6-character unique ID to complete the survey.",
                      style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w400, fontSize: 16)),
                ],
              ),
            )),
            //SizedBox(height: 20),
           Container(padding:EdgeInsets.all(16),child:
            ButtonTheme(
                minWidth: 360.0,
                height: 48.0,child:
             FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
              child: new Text("YES", style: TextStyle(
                  color: HexColor('#FFFFFF'),
                  fontWeight: FontWeight.w700,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16),),
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(48))),
              color: Colors.black,
              textColor: Colors.black87,
              onPressed: () {Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => T4D()),
                SlideRoute(page: PinCodeVerificationScreen(),duration: 600,direction: 'Left'),
              );},)


            )),
            Container(padding:EdgeInsets.fromLTRB(16,0,16,0),child:
             ButtonTheme(
                minWidth: 360.0,
                height: 48.0,child:
             FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
              child: new Text("NO / I DON'T KNOW", style: TextStyle(
                  color: HexColor('#FFFFFF'),
                  fontWeight: FontWeight.w700,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16),),
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(48))),
              color: Colors.black,
              textColor: Colors.black87,
              onPressed: () {Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => T4D()),
                SlideRoute(page: S2A(),duration: 600,direction: 'Left'),
              );},)


            ))
          ]

          ),

    );
    //);
  }
}

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userdata');

  Future<void> updateUserData(String surveycode) async {
    return await userCollection.doc(uid).set({
      'survey_code': surveycode,
    });
  }

}

class S1B extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final bool end;
  GlobalKey<NavigatorState> _key = GlobalKey();

  void sendEmail() async{
    var firebaseUser = _firebaseAuth.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("mail").doc(firebaseUser.uid).update({
      "to": "sedmorteza@gmail.com",
      "message": {
        "subject": "$firebaseUser.uid Submission Confirmation",
        "text": "Submission for $firebaseUser.email recieved.",
      },
    });


  }

  S1B(this.end);
  @override
  Widget build(BuildContext context) {
    var firebaseUser = _firebaseAuth.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;
    return  Scaffold(backgroundColor: Colors.white,
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
                //onPressed: () =>Navigator.push(context, SlideRoute(page: S1C(),duration: 600,direction: 'Left'))),
              onPressed: () => Navigator.pop(context)),*/
          ),
          body:
             ListView(children: [
               Container(padding: EdgeInsets.fromLTRB(0,32,0,0),
                   child: Image.asset('assets/images/T0B_Cinderella.png',width: 152, height: 100)),
              Container(padding: EdgeInsets.fromLTRB(32, 16, 32, 0), child:
              RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w400,
                    height:1.4,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  end? TextSpan(text: "Got it. An Iambic team member will reach out to you with your Unique ID.\n\nIn the meantime, would you like to submit a set of scans? You will gain an entry into the Bespoke Sneaker Sweepstakes each time you complete the scans.\n\nThis will help us improve our software.")
                  :TextSpan(text: "Would you like to submit another set of scans? You'll gain an additional entry in the Bespoke Sneaker Sweepstakes for each new set.\n\n")
                ],
              ),
            )),
            //SizedBox(height: 20),
           Container(padding:EdgeInsets.fromLTRB(32,32,32,0),child:
            ButtonTheme(
                minWidth: 360.0,
                height: 48.0,child:
             FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
              child: end? Text("YES, LET'S SCAN", style: TextStyle(
                  color: HexColor('#FFFFFF'),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16)):Text("YES, SCAN AGAIN", style: TextStyle(
                  color: HexColor('#FFFFFF'),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16))
               ,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(48))),
              color: Colors.black,
              textColor: Colors.black87,
              onPressed: () async{
                firestoreInstance.collection("mail").doc(firebaseUser.uid).set({
                  "to": userEmail,//"mike@iambic.co",
                  "bcc":['mike@iambic.co','frank@iambic.co'],
                  "message": {
                    "subject": 'Iambic: Research App Submission '+_firebaseAuth.currentUser.uid+' Received',//_firebaseAuth.currentUser.uid,
                    "text": 'Greetings,\n\nWe have received your submission through the Iambic Research App! Next, we will be reviewing your submission to confirm completion and will get back to you once our review is complete.\n\nThank you for being part of the Iambic Research experience. If you have any questions, please contact us at iambisphere@iambic.co\n\nBest,\n\nTeam Iambic'//userEmail,
                  },
                }).then((_) {
                  print("success!");
                });
                Navigator.push(
                  context,
                  SlideRoute(page: bubble_level(view: 'Top', side: 'Right',rescan: true),duration: 600,direction: 'Left'),
                );
                },)
            )),
               //SizedBox(height: 20),
               Container(padding:EdgeInsets.fromLTRB(32,24,32,0),child:
               ButtonTheme(
                   minWidth: 360.0,
                   height: 48.0,child:
               FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                 child: Text("NO, LET'S FINISH", style: TextStyle(
                     color: HexColor('#FFFFFF'),
                     fontWeight: FontWeight.w700,
                     letterSpacing: 1.5,
                     //fontStyle: FontStyle.italic,
                     fontFamily: 'Barlow',
                     fontSize: 16)),
                 shape: new RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(Radius.circular(48))),
                 color: Colors.black,
                 textColor: Colors.black87,
                 onPressed: () async {
                   firestoreInstance.collection("mail").doc(firebaseUser.uid).set({
                     "to": userEmail,//"mike@iambic.co",
                     "bcc":['mike@iambic.co','frank@iambic.co'],
                     "message": {
                       "subject": 'Iambic: Research App Submission '+_firebaseAuth.currentUser.uid+' Received',//_firebaseAuth.currentUser.uid,
                       "text": 'Greetings,\n\nWe have received your submission through the Iambic Research App! Next, we will be reviewing your submission to confirm completion and will get back to you once our review is complete.\n\nThank you for being part of the Iambic Research experience. If you have any questions, please contact us at iambisphere@iambic.co\n\nBest,\n\nTeam Iambic'
                     },
                   }).then((_) {
                     print("success!");
                   });
                   //_firebaseAuth.signOut();
                   //signOutGoogle();
                   Navigator.push(
                     context,
                     SlideRoute(page: S1D(),duration: 600,direction: 'Left'),
                   );
                   ;},)
               )),
          ]
          ),

    );
    //);
  }
}

class S1D extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GlobalKey<NavigatorState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
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
        //leading: IconButton(
          //  icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
          //  onPressed: () =>Navigator.push(context, SlideRoute(page: S1C(),duration: 600,direction: 'Left'))),
        //onPressed: () => Navigator.pop(context)),
      ),
      body:
      ListView(children: [
        Container(padding: EdgeInsets.fromLTRB(0,0,16,0),
            child: Image.asset('assets/images/V2I_V3B.png',width: 360, height: 260)),
        Container(padding: EdgeInsets.fromLTRB(32, 16, 32, 16), child:
        RichText(
          text: TextSpan(
            style: TextStyle(color: HexColor('#222222'),
                fontWeight: FontWeight.w400,
                height:1.5,
                fontFamily: 'Barlow',
                fontSize: 16),
            children: <TextSpan>[
              TextSpan(text: "You’re all set! We’ll let you know if you’re a winner in our Bespoke Sneaker Sweepstakes. Thanks again for participating!")
            ],
          ),
        )),
        //SizedBox(height: 20),
        Container(padding:EdgeInsets.fromLTRB(32,8,32,0),child:
        ButtonTheme(
            minWidth: 360.0,
            height: 48.0,child:
        RaisedButton(
          child: Text("EXIT", style: TextStyle(letterSpacing: 1.5,
              color: HexColor('#FFFFFF'),
              fontWeight: FontWeight.w600,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Barlow',
              fontSize: 16)),
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(48))),
          color: Colors.black,
          textColor: Colors.black87,
          onPressed: () async{
            await _firebaseAuth.signOut();
            Navigator.push(
              context,
              SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
            );
            ;},)
        )),
      ]
      ),

    );
    //);
  }
}

class PinCodeVerificationScreen extends StatefulWidget {
  //final String phoneNumber;

  //PinCodeVerificationScreen(this.phoneNumber);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final Email email = Email(
    body: 'help find their ID',
    subject: 'Forgotten ID',
    recipients: ['smhaieri@gmail.com'],
    //cc: ['cc@example.com'],
    //bcc: ['bcc@example.com'],
    //attachmentPaths: ['/path/to/attachment.zip'],
    isHTML: false,
  );

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  Future saveToFirebase(String surveycode) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final uid= _firebaseAuth.currentUser.uid;
    //User user = await FirebaseAuth.instance.currentUser();
    //final uid = user.uid;
    await DatabaseService(uid:uid).updateUserData(surveycode);
  }

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
                  ////await googleSignIn.signOut();
                  Navigator.push(
                    context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                  );},
                child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                    child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
          ],*/
        ),
       key: scaffoldKey,
       body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32),
                child: RichText(
                  text: TextSpan(
                      text: "Enter your 6-character unique ID issued by an Iambic team member:",
                      style: TextStyle(fontFamily:'Barllow',fontWeight:FontWeight.w500, color: Colors.black, fontSize: 20)),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(child:Text(
                  hasError ? "*Please enter a valid ID to continue" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 50),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      obscuringCharacter: '*',
                      //blinkWhenObscuring: true,
                      animationType: AnimationType.fade,


                      pinTheme: PinTheme(
                        //shape: PinCodeFieldShape.underline,
                        //borderRadius: BorderRadius.circular(5),
                        fieldHeight: 40,
                        fieldWidth: 40,
                        inactiveFillColor:Colors.transparent,
                        inactiveColor:Colors.grey,
                        activeFillColor:Colors.white
                        //hasError ? Colors.tealAccent : Colors.transparent,
                      ),
                      //cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: false,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.text,
                      //boxShadows: [
                      //  BoxShadow(
                      //    offset: Offset(0, 1),
                      //    color: Colors.black12,
                      //    blurRadius: 10,
                      //  )
                      //],
                      onCompleted: (v) {
                        print("Completed");

                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                    onPressed: () async{
                  //await FlutterEmailSender.send(email);
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => T4D()),
                    SlideRoute(page: S1B(true),duration: 600,direction: 'Left'),
                  );
                 },child:Text(
                  "Forgot Unique ID?",
                  style: TextStyle(
                      color: HexColor('00CED3'),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ))),
              ),
             Expanded(
               child: Container(padding:EdgeInsets.only(bottom:16),child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                    onPressed: () async {
                      formKey.currentState.validate();
                      // conditions for validating
                      if (currentText.length != 6 && currentText != "nonexistent") {
                        errorController.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() {
                          hasError = true;
                        });
                      } else {
                        var firebaseUser = FirebaseAuth.instance.currentUser;
                        //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
                        //final uid = user.uid;
                        //final uid = firebaseUser.uid;
                        final firestoreInstance = FirebaseFirestore.instance;
                        firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                            .update({"survey_code": currentText}).then((_) {
                          print("success!");
                        });
                        //await saveToFirebase(currentText);
                        setState(() {
                          hasError = false;
                          /*scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Got it!!"),
                            duration: Duration(seconds: 2),
                          ));*/
                        });
                        Navigator.push(
                          context,
                          //MaterialPageRoute(builder: (context) => T4D()),
                          SlideRoute(page: T2B(),duration: 600,direction: 'Left'),
                        );
                      }
                    },
                    child: Align(alignment: Alignment.bottomRight,
                        child: Text(
                          "NEXT".toUpperCase(),
                          style: TextStyle(
                              color: HexColor('00CED3'),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                )),

            ],
          ),
        ),
      ),

    );
  }
}

class S1C extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),
          body:
          ShoeTypeCheckboxWidget(),

    );
    //);
  }
}

class ShoeTypeCheckboxWidget extends StatefulWidget {
  @override
  ShoeTypeCheckboxWidgetState createState() => new ShoeTypeCheckboxWidgetState();
}

class ShoeTypeCheckboxWidgetState extends State {
  var _controller = ScrollController();
  bool atEnd=false;

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        atEnd=true;
      }
    });
  }

  Map<String, bool> values = {
    'Athletic shoes/sneakers': false,
    'Boat shoes': false,
    'Boots/booties': false,
    'Clogs/mules': false,
    'Fashion sneakers': false,
    'Flats': false,
    'Heels': false,
    'Loafers': false,
    'Oxfords/derbys': false,
    'Sandals': false,
    'Slippers': false,
    'Not Listed': false,
  };

  var tmpArray = [];
  int count=0;

  getCheckboxItems(){
    tmpArray.clear();
    values.forEach((key, value) {
      if(value == true && tmpArray.length<4)
      {
        tmpArray.add(key);
        tmpArray.where((f) => f.startsWith('t')).toList();
        print(tmpArray.where((value) => value == true).length);
      }else{
        tmpArray.remove(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.

  }

  @override
  Widget build(BuildContext context) {
    return Column (children: <Widget>[
      Container(padding: EdgeInsets.fromLTRB(16, 16, 16, 16), child:
       RichText(
        text: TextSpan(
          style: TextStyle(color: HexColor('#222222'),
              fontWeight: FontWeight.w400,
              height:1.5,
              fontFamily: 'Barlow',
              fontSize: 18),
          children: <TextSpan>[
            TextSpan(text: "Got it! To enter our Bespoke Sneaker Sweepstakes, tell us your favorite shoe types. Please check up to three choices from the scrollable list below:"),
            ]
       ))),
      Expanded(
        child :
        ListView(controller: _controller,
          children: values.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: values[key],
              activeColor: HexColor('#00CED3'),
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                    if(count<3) {
                      values[key] = value;
                      values[key]==true ? count+=1:count-=1;
                      }else{
                      if(values[key] == true)  {
                        values[key] = value;
                        count -= 1;
                      }else{
                        Scaffold.of(context).showSnackBar(
                          SnackBar(backgroundColor: HexColor('#FFC40F'),
                            content: Text('You can only select up to three!',style: TextStyle(color: HexColor('#222222'),fontWeight:FontWeight.bold)),
                          ),
                        );
                      }
                    }
                });
              },
            );
          }).toList(),
        ),
      ),
      //if(atEnd)
      if(count>0)
      FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onPressed: () async{
            var firebaseUser = FirebaseAuth.instance.currentUser;
            //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
            final firestoreInstance = FirebaseFirestore.instance;
            //final Map<String, dynamic> tempMap =values;
            //tempMap.removeWhere((String key, dynamic value)=> value==false);
            getCheckboxItems();
            firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                .update({"shoe_type": tmpArray}).then((_) {
              print("success!");
            });
            Navigator.push(
            context,
            SlideRoute(page: T2B(),duration: 600,direction: 'Left'),
          );},
          child: Container(padding: EdgeInsets.fromLTRB(16, 0, 0, 0), alignment:Alignment.bottomRight,
              child: Text('SUBMIT',
                  style: new TextStyle(letterSpacing: 1.5, fontFamily: 'Barlow', fontSize: 16.0, fontWeight: FontWeight.w700, color: HexColor('#00CED3'))))
      ),
    ]);
  }
}


class S2B extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title:Center(// Align(alignment: Alignment(-0.25, 0),
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),
          body:
          GenderCheckboxWidget(),

    );
    //);
  }
}

class GenderCheckboxWidget extends StatefulWidget {
  @override
  GenderCheckboxWidgetState createState() => new GenderCheckboxWidgetState();
}

class GenderCheckboxWidgetState extends State {
  var _controller = ScrollController();
  bool atEnd=false;
  String gender;
  @override
  void initState() {
    super.initState();
    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        atEnd=true;
      }
    });
  }

  Map<String, bool> values = {
    'Female': false,
    //'Gender non-conforming': false,
    //'Gender variant': false,
   // 'Intersex': false,
    'Male': false,
    'Non-binary': false,
    //'Trans': false,
    'Custom': false,
  };

  var tmpArray = [];
  int count=0;

  getCheckboxItems(){
    tmpArray.clear();
    values.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    //tmpArray.clear();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(padding: EdgeInsets.all(16), child:
      RichText(
          text: TextSpan(
              style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w600,
                  height:1.4,
                  fontFamily: 'Barlow',
                  fontSize: 22),
              children: <TextSpan>[
                TextSpan(text: "Gender"),
                TextSpan(text: "\n\nHow do you identify?",style:TextStyle(fontWeight: FontWeight.w400,
                    fontSize: 18)),
                //TextSpan(text: "\n\nThis information is optional and will not be shared with any third parties.",style:TextStyle(fontWeight: FontWeight.w700,
                    //fontSize: 16, color: HexColor("9B9B9B"))),
              ]
          ))),
      Expanded(child:RawScrollbar(isAlwaysShown: true,thumbColor: HexColor("#00CED3"),
          child:ListView(children: values.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key,style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w400,
                  height:1.4,
                  fontFamily: 'Barlow',
                  fontSize: 18)),
              value: values[key],
              activeColor: HexColor('#00CED3'),
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  if(count<2) {
                    values[key] = value;
                    values[key]==true ? count+=1:count-=1;
                  }else{
                    if(values[key] == true)  {
                      values[key] = value;
                      count -= 1;
                    }else{
                      Scaffold.of(context).showSnackBar(
                        SnackBar(backgroundColor: HexColor('#FFC40F'),
                          content: Text('You can only select two!',style: TextStyle(color: HexColor('#222222'),fontWeight:FontWeight.bold)),
                        ),
                      );
                    }
                  }
                });
              },
            );
          }).toList(),
        )),
      ),
      //if(atEnd)
      if(values['Custom'] == true)
        Container(padding: EdgeInsets.fromLTRB(16,16,16,16),width:width,child:Text("Please specify if you selected 'Custom'",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w400,
            height:1.4,
            fontFamily: 'Barlow',
            fontSize: 18))),
      if(values['Custom'] == true)
      Container(padding: EdgeInsets.fromLTRB(16,0,16,32),width:width,child:TextFormField(
        key: new Key('gender'),
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
            floatingLabelBehavior:FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.only(left: 24.0),
            //labelText: "Age",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: BorderSide(
                color: HexColor('#A5E0E5'),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: BorderSide(
                color: HexColor('#A5E0E5'),
                width: 2.0,
              ),
            ),
            hintText: 'I identify as...'),
        autocorrect: false,
        //validator: (val) =>
        //val.isEmpty
        //? 'can\'t be empty.'
        //: null,
        onChanged: (val) => gender = val,
      )),
      if(count>0)
      FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onPressed: () async{
            var firebaseUser = FirebaseAuth.instance.currentUser;
            //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
            final firestoreInstance = FirebaseFirestore.instance;
            //final Map<String, dynamic> tempMap =values;
            //tempMap.removeWhere((String key, dynamic value)=> value==false);
            getCheckboxItems();
            firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                .update({"gender": tmpArray,"custom_gender":gender}).then((_) {
              print("success!");
            });
            Navigator.push(
              context,
              SlideRoute(page: S2C(),duration: 600,direction: 'Left'),
            );},
          child: Container(padding: EdgeInsets.fromLTRB(0, 0, 8, 16), alignment:Alignment.bottomRight,
              child: Text('NEXT',
                  style: new TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1.5, fontSize: 16.0, color: HexColor('#00CED3'))))
      ),
    ]);
  }
}

class S1D1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      PainCheckboxWidget(),

    );
    //);
  }
}

class PainCheckboxWidget extends StatefulWidget {
  @override
  PainCheckboxWidgetState createState() => new PainCheckboxWidgetState();
}

class PainCheckboxWidgetState extends State {
  var _controller = ScrollController();
  bool atEnd=false;
  String pain_area;
  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        atEnd=true;
      }
    });
  }

  Map<String, bool> values = {
    'Ankle': false,
    'Arch': false,
    'Ball of foot': false,
    'Heel': false,
    'Toes': false,
    'Top of foot': false,
    'Other': false,
  };

  var tmpArray = [];
  int count=0;

  getCheckboxItems(){
    tmpArray.clear();
    values.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },
    child:
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(padding: EdgeInsets.all(16), child:
      RichText(
          text: TextSpan(
              style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w600,
                  height:1.5,
                  fontFamily: 'Barlow',
                  fontSize: 22),
              children: <InlineSpan>[
                TextSpan(text: "Areas of Foot Pain\n"),
                WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(height: 35)),
                TextSpan(text: "Where on your foot are you experiencing pain? Please check all that apply.",style:TextStyle(fontWeight: FontWeight.w400,
                    fontSize: 18,height:1.5)),
              ]
          ))),

      Expanded(child:RawScrollbar(isAlwaysShown: true,thumbColor: HexColor("#00CED3"),
        child:ListView(
        children: values.keys.map((String key) {
          return CheckboxListTile(
            title: Text(key,style: TextStyle(color: HexColor('#222222'),
                fontWeight: FontWeight.w400,
                height:1.4,
                fontFamily: 'Barlow',
                fontSize: 18)),
            value: values[key],
            activeColor: HexColor('#00CED3'),
            checkColor: Colors.white,
            onChanged: (bool value) {
              setState(() {
                if(count<10) {
                  values[key] = value;
                  values[key]==true ? count+=1:count-=1;
                }else{
                  if(values[key] == true)  {
                    values[key] = value;
                    count -= 1;
                  }else{
                    //Scaffold.of(context).showSnackBar(
                      //SnackBar(backgroundColor: HexColor('#FFC40F'),
                       // content: Text('You can only select one!',style: TextStyle(color: HexColor('#222222'),fontWeight:FontWeight.bold)),
                      //),
                    //);
                  }
                }
              });
            },
          );
        }).toList(),
      )),
      ),
      //if(atEnd)
      if(values['Other'] == true)
        Container(padding: EdgeInsets.fromLTRB(16.0,8,16,16),width:width,child:Text("Please specify if you selected 'Other'")),
      if(values['Other'] == true)
        Container(padding: EdgeInsets.fromLTRB(16.0,0,16,0),height:48, width:width,child:TextFormField(
          key: new Key('pain_area'),
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
              floatingLabelBehavior:FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.only(left: 24.0),
              //labelText: "Age",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48.0),
                borderSide: BorderSide(
                  color: HexColor('#A5E0E5'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48.0),
                borderSide: BorderSide(
                  color: HexColor('#A5E0E5'),
                  width: 2.0,
                ),
              ),
              hintText: 'I feel pain at...'),
          autocorrect: false,
          //validator: (val) =>
          //val.isEmpty
          //? 'can\'t be empty.'
          //: null,
          onChanged: (val) => pain_area = val,
        )),
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
                    child:Column(children: [
                      InkWell(child:Container(alignment: Alignment.center, child:Column(children:[
                        Icon(Icons.keyboard_arrow_down,color: HexColor('#828282'),),
                        Text("Close",style: TextStyle(color: HexColor('#828282'),
                            fontWeight: FontWeight.w600,
                            //fontStyle: FontStyle.italic,
                            fontFamily: 'Barlow',
                            fontSize: 16)),
                      ])), onTap: () {Navigator.pop(context);},
                      ),
                      Image.asset('assets/images/S1DM.png')
                    ]));
              }
              ,isScrollControlled:true,);
          },
          child: Container(padding: EdgeInsets.fromLTRB(8, 16, 16, 16),
              child: Text('Unsure? View diagram of foot.', style: new TextStyle(
                  fontSize: 16.0, color: HexColor('#00CED3'),decoration: TextDecoration.underline)))
      ),
      if(count>0)
      FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onPressed: () async{
            var firebaseUser = FirebaseAuth.instance.currentUser;
            //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
            final firestoreInstance = FirebaseFirestore.instance;
            //final Map<String, dynamic> tempMap =values;
            //tempMap.removeWhere((String key, dynamic value)=> value==false);
            getCheckboxItems();
            firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                .update({"pain_area": tmpArray,"unlisted_pain_area":pain_area}).then((_) {
              print("success!");
            });
            Navigator.push(
              context,
              SlideRoute(page: S1D2(),duration: 600,direction: 'Left'),
            );},
          child: Container(padding: EdgeInsets.fromLTRB(16, 16, 8, 16), alignment:Alignment.bottomRight,
              child: Text('NEXT',
                  style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
      ),
    ]));
  }
}

class S1D2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
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
            onPressed: () =>Navigator.push(context, SlideRoute(page: S1D1(),duration: 600,direction: 'Left'))),*/
            //onPressed: () => Navigator.pop(context)),
        /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      PainDegreeCheckboxWidget(),

    );
    //);
  }
}

class S1BGender extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      GenderCheckboxWidget(),

    );
    //);
  }
}

class PainDegreeCheckboxWidget extends StatefulWidget {
  @override
  PainDegreeCheckboxWidgetState createState() => new PainDegreeCheckboxWidgetState();
}

class PainDegreeCheckboxWidgetState extends State {
  var _controller = ScrollController();
  bool atEnd=false;
  String pain_degree;
  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        atEnd=true;
      }
    });
  }

  Map<String, bool> values = {
    'I walk or stand less.': false,
    'I struggle to walk long distances without stopping to rest my feet.': false,
    'My activities (e.g., shopping, housework, social life) are inhibited.': false,
    'I walk irregularly or at a slower pace. ': false,
    'Other': false,
  };

  var tmpArray = [];
  int count=0;

  getCheckboxItems(){
    tmpArray.clear();
    values.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      GestureDetector(
        onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },
    child:
      Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(padding: EdgeInsets.all(16), child:
      RichText(
          text: TextSpan(
              style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w600,
                  height:1.5,
                  fontFamily: 'Barlow',
                  fontSize: 22),
              children: <InlineSpan>[
                TextSpan(text: "Degree of Foot Pain\n"),
                WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(height: 35)),
                TextSpan(text: "How does foot pain impact your life on most/all days?  Please check all that apply.",style:TextStyle(fontWeight: FontWeight.w400,
                    fontSize: 18,height:1.5)),
              ]
          ))),

      Expanded(child:ListView(
        children: values.keys.map((String key) {
          return CheckboxListTile(
            title: Text(key),
            value: values[key],
            activeColor: HexColor('#00CED3'),
            checkColor: Colors.white,
            onChanged: (bool value) {
              setState(() {
                if(count<10) {
                  values[key] = value;
                  values[key]==true ? count+=1:count-=1;
                }else{
                  if(values[key] == true)  {
                    values[key] = value;
                    count -= 1;
                  }else{
                    //Scaffold.of(context).showSnackBar(
                    //SnackBar(backgroundColor: HexColor('#FFC40F'),
                    // content: Text('You can only select one!',style: TextStyle(color: HexColor('#222222'),fontWeight:FontWeight.bold)),
                    //),
                    //);
                  }
                }
              });
            },
          );
        }).toList(),
      ),
      ),
      //if(atEnd)
      if(values['Other'] == true)
        Container(padding: EdgeInsets.fromLTRB(16.0,0,16,16),width:width,child:Text("Please specify if you selected 'Other'",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w400,
            height:1.5,
            fontFamily: 'Barlow',
            fontSize: 18))),
      if(values['Other'] == true)
        Container(padding: EdgeInsets.fromLTRB(16.0,0,16,0),height:48, width:width,child:TextFormField(
          key: new Key('pain_degree'),
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
              floatingLabelBehavior:FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.only(left: 24.0),
              //labelText: "Age",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48.0),
                borderSide: BorderSide(
                  color: HexColor('#A5E0E5'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48.0),
                borderSide: BorderSide(
                  color: HexColor('#A5E0E5'),
                  width: 2.0,
                ),
              ),
              hintText: 'Due to foot pain, I...',hintStyle: TextStyle(
            color: HexColor('969696'),fontSize: 16,fontWeight: FontWeight.w500, // Change background color for hint text
          ),),
          autocorrect: false,
          //validator: (val) =>
          //val.isEmpty
          //? 'can\'t be empty.'
          //: null,
          onChanged: (val) => pain_degree = val,
        )),
      if(count>0)
      FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onPressed: () async{
            var firebaseUser = FirebaseAuth.instance.currentUser;
            //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
            final firestoreInstance = FirebaseFirestore.instance;
            //final Map<String, dynamic> tempMap =values;
            //tempMap.removeWhere((String key, dynamic value)=> value==false);
            getCheckboxItems();
            firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                .update({"pain_degree": tmpArray,"unlisted_pain_degree":pain_degree}).then((_) {
              print("success!");
            });
            Navigator.push(
              context,
              SlideRoute(page: S1E(),duration: 600,direction: 'Left'),
            );},
          child: Container(padding: EdgeInsets.fromLTRB(16, 8, 8, 16), alignment:Alignment.bottomRight,
              child: Text('NEXT',
                  style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
      ),
    ]));
  }
}

class S1E extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
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
            //onPressed: () => Navigator.pop(context)),
          onPressed: () =>Navigator.push(context, SlideRoute(page: S1D2(),duration: 600,direction: 'Left'))),*/
        /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      IssuesCheckboxWidget(),

    );
    //);
  }
}

class IssuesCheckboxWidget extends StatefulWidget {
  @override
  IssuesCheckboxWidgetState createState() => new IssuesCheckboxWidgetState();
}

class IssuesCheckboxWidgetState extends State {
  var _controller = ScrollController();
  bool atEnd=false;
  String foot_issues;
  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        atEnd=true;
      }
    });
  }

  Map<String, bool> values = {
    'Arch: flat': false,
    'Arch: high': false,
    "Athlete's foot": false,
    'Blisters': false,
    'Bunions or bunionettes': false,
    'Calluses': false,
    'Corns': false,
    'Hammertoes or claw toes': false,
    'Heel spurs or plantar fasciitis': false,
    'Ingrown toenails': false,
    'Numbness or tingling sensations': false,
    'Other': false,
  };

  var tmpArray = [];
  int count=0;

  getCheckboxItems(){
    tmpArray.clear();
    values.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      GestureDetector(
        onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },
    child:
      Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(padding: EdgeInsets.all(16), child:
      RichText(
          text: TextSpan(
              style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w600,
                  height:1.5,
                  fontFamily: 'Barlow',
                  fontSize: 22),
              children: <InlineSpan>[
                TextSpan(text: "Past ",style:TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: "Foot Issues\n"),
                WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(height: 35)),
                TextSpan(text: "Have you experienced any of the following conditions in the past? Please check all that apply.",style:TextStyle(fontWeight: FontWeight.w400,
                    fontSize: 18,height:1.5)),
              ]
          ))),

      Expanded(child:RawScrollbar(isAlwaysShown: true,thumbColor: HexColor("#00CED3"),
        child:ListView(
        children: values.keys.map((String key) {
          return CheckboxListTile(
            title: Text(key),
            value: values[key],
            activeColor: HexColor('#00CED3'),
            checkColor: Colors.white,
            onChanged: (bool value) {
              setState(() {
                if(count<15) {
                  values[key] = value;
                  values[key]==true ? count+=1:count-=1;
                }else{
                  if(values[key] == true)  {
                    values[key] = value;
                    count -= 1;
                  }else{
                    //Scaffold.of(context).showSnackBar(
                    //SnackBar(backgroundColor: HexColor('#FFC40F'),
                    // content: Text('You can only select one!',style: TextStyle(color: HexColor('#222222'),fontWeight:FontWeight.bold)),
                    //),
                    //);
                  }
                }
              });
            },
          );
        }).toList(),
      ),
      )),
      //if(atEnd)
      if(values['Other'] == true)
        Container(padding: EdgeInsets.fromLTRB(16.0,0,16,16),width:width,child:Text("Please specify if you selected 'Other'",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w400,
            height:1.5,
            fontFamily: 'Barlow',
            fontSize: 18))),
      if(values['Other'] == true)
        Container(padding: EdgeInsets.fromLTRB(16.0,0,16,0),height:48, width:width,child:TextFormField(
          key: new Key('foot_issues'),
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
            floatingLabelBehavior:FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.only(left: 24.0),
            //labelText: "Age",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: BorderSide(
                color: HexColor('#A5E0E5'),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: BorderSide(
                color: HexColor('#A5E0E5'),
                width: 2.0,
              ),
            ),
            hintText: "I've experienced...",hintStyle: TextStyle(
            color: HexColor('969696'),fontSize: 16,fontWeight: FontWeight.w500, // Change background color for hint text
          ),),
          autocorrect: false,
          //validator: (val) =>
          //val.isEmpty
          //? 'can\'t be empty.'
          //: null,
          onChanged: (val) => foot_issues = val,
        )),
      //if(count>0)
      FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onPressed: () async{
            var firebaseUser = FirebaseAuth.instance.currentUser;
            //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
            final firestoreInstance = FirebaseFirestore.instance;
            //final Map<String, dynamic> tempMap =values;
            //tempMap.removeWhere((String key, dynamic value)=> value==false);
            getCheckboxItems();
            firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                .update({"foot_issues": tmpArray,"unlisted_foot_issues":foot_issues}).then((_) {
              print("success!");
            });
            Navigator.push(
              context,
              SlideRoute(page: S2A2(),duration: 600,direction: 'Left'),
            );},
          child: Container(padding: EdgeInsets.fromLTRB(16, 8, 8, 16), alignment:Alignment.bottomRight,
              child: Text('NEXT',
                  style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
      ),
    ]));
  }
}

class S2A2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
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
            onPressed: () =>Navigator.push(context, SlideRoute(page: S1E(),duration: 600,direction: 'Left'))),*/
            //onPressed: () => Navigator.pop(context)),
        /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      FavoriteCheckboxWidget(),

    );
    //);
  }
}

class FavoriteCheckboxWidget extends StatefulWidget {
  @override
  FavoriteCheckboxWidgetState createState() => new FavoriteCheckboxWidgetState();
}

class FavoriteCheckboxWidgetState extends State {
  var _controller = ScrollController();
  bool atEnd=false;
  String favorite_pair,favorite_pair_why;
  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        atEnd=true;
      }
    });
  }

  Map<String, bool> values = {
    'Comfortable': false,
    'Cushiony': false,
    "Durable": false,
    'Easy-on/off': false,
    'Fits well': false,
    'Lightweight': false,
    'Stylish': false,
    'Versatile': false,
    'Other': false,
  };

  var tmpArray = [];
  int count=0;

  getCheckboxItems(){
    tmpArray.clear();
    values.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },
    child:Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(padding: EdgeInsets.all(16), child:
      RichText(
          text: TextSpan(
              style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w600,
                  height:1.5,
                  fontFamily: 'Barlow',
                  fontSize: 22),
              children: <InlineSpan>[
                TextSpan(text: "Your Favorite Pair\n"),
                WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(height: 35)),
                TextSpan(text: "Of all the shoes you own, ",style:TextStyle(fontWeight: FontWeight.w400,
                    fontSize: 18,height:1.5)),
                TextSpan(text: "which pair is your favorite?",style:TextStyle(fontWeight: FontWeight.w700,
                    fontSize: 18,height:1.5)),
              ]
          ))),
      Container(padding: EdgeInsets.fromLTRB(16.0,0,16,0),height:48, width:width,child:TextFormField(
        key: new Key('favorite_pair'),
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
          floatingLabelBehavior:FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.only(left: 24.0),
          //labelText: "Age",
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(48.0),
            borderSide: BorderSide(
              color: HexColor('#A5E0E5'),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(48.0),
            borderSide: BorderSide(
              color: HexColor('#A5E0E5'),
              width: 2.0,
            ),
          ),
          hintText: "My favorite pair is...",hintStyle: TextStyle(
          color: HexColor('969696'),fontSize: 16,fontWeight: FontWeight.w500, // Change background color for hint text
        ),),
        autocorrect: false,
        //validator: (val) =>
        //val.isEmpty
        //? 'can\'t be empty.'
        //: null,
        onChanged: (val) => favorite_pair = val,
      )),
      Container(padding: EdgeInsets.all(16), child:
      RichText(
          text: TextSpan(
              style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w500,
                  height:1.5,
                  fontFamily: 'Barlow',
                  fontSize: 20),
              children: <InlineSpan>[
                TextSpan(text: "Why? "),
                TextSpan(text: "(please check all that apply)",style:TextStyle(fontWeight: FontWeight.w400,
                    fontSize: 16,height:1.5)),
              ]
          ))),
    Expanded(child:RawScrollbar(isAlwaysShown: true,thumbColor: HexColor("#00CED3"),
    child:ListView(
        children: values.keys.map((String key) {
          return CheckboxListTile(
            title: Text(key),
            value: values[key],
            activeColor: HexColor('#00CED3'),
            checkColor: Colors.white,
            onChanged: (bool value) {
              setState(() {
                if(count<15) {
                  values[key] = value;
                  values[key]==true ? count+=1:count-=1;
                }else{
                  if(values[key] == true)  {
                    values[key] = value;
                    count -= 1;
                  }else{
                    //Scaffold.of(context).showSnackBar(
                    //SnackBar(backgroundColor: HexColor('#FFC40F'),
                    // content: Text('You can only select one!',style: TextStyle(color: HexColor('#222222'),fontWeight:FontWeight.bold)),
                    //),
                    //);
                  }
                }
              });
            },
          );
        }).toList(),
       ),
      ),
    ),
      //if(atEnd)
      if(values['Other'] == true)
        Container(padding: EdgeInsets.fromLTRB(16.0,0,16,16),width:width,child:Text("Please specify if you selected 'Other'",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w400,
            height:1.5,
            fontFamily: 'Barlow',
            fontSize: 18))),
      if(values['Other'] == true)
        Container(padding: EdgeInsets.fromLTRB(16.0,0,16,0),height:48, width:width,child:TextFormField(
          key: new Key('favorite_pair_why'),
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
            floatingLabelBehavior:FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.only(left: 24.0),
            //labelText: "Age",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: BorderSide(
                color: HexColor('#A5E0E5'),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: BorderSide(
                color: HexColor('#A5E0E5'),
                width: 2.0,
              ),
            ),
            hintText: "I like how...",hintStyle: TextStyle(
            color: HexColor('969696'),fontSize: 16,fontWeight: FontWeight.w500, // Change background color for hint text
          ),),
          autocorrect: false,
          //validator: (val) =>
          //val.isEmpty
          //? 'can\'t be empty.'
          //: null,
          onChanged: (val) => favorite_pair_why = val,
        )),
     FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onPressed: () async{
            var firebaseUser = FirebaseAuth.instance.currentUser;
            //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
            final firestoreInstance = FirebaseFirestore.instance;
            //final Map<String, dynamic> tempMap =values;
            //tempMap.removeWhere((String key, dynamic value)=> value==false);
            getCheckboxItems();
            firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                .update({"favorite_pair_why": tmpArray,"unlisted_favorite_pair_why":favorite_pair_why}).then((_) {
              print("success!");
            });
            Navigator.push(
              context,
              SlideRoute(page: S2B2(),duration: 600,direction: 'Left'),
            );},
          child: Container(padding: EdgeInsets.fromLTRB(16, 16, 8, 16), alignment:Alignment.bottomRight,
              child: Text('NEXT',
                  style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
      ),
    ]));
  }
}

class S2D extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String Discomf_Cause;
    return  Scaffold(backgroundColor: Colors.white,
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child:
          Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Expanded(child:RawScrollbar(isAlwaysShown: true,thumbColor: HexColor("#00CED3"),
                child:ListView(
                    children:[
                      Container(padding: EdgeInsets.all(16), child:
                      RichText(
                          text: TextSpan(
                              style: TextStyle(color: HexColor('#222222'),
                                  fontWeight: FontWeight.w600,
                                  height:1.5,
                                  fontFamily: 'Barlow',
                                  fontSize: 22),
                              children: <InlineSpan>[
                                TextSpan(text: "The Tricky Fit\n"),
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: SizedBox(height: 35)),
                                TextSpan(text: "When shoes don’t fit, where does the discomfort come from? Please check all that apply.",style:TextStyle(fontWeight: FontWeight.w400,
                                    fontSize: 18,height:1.5)),
                              ]
                          ))),
        Padding(padding:EdgeInsets.fromLTRB(16,0,16,0),child:S2DCheckboxWidget('Arch height','Too high','Too low')),
        Padding(padding:EdgeInsets.fromLTRB(16,8,16,0),child:S2DCheckboxWidget('Heel','Achilles area chafing','Heel slippage')),
        Padding(padding:EdgeInsets.fromLTRB(16,8,16,0),child:S2DCheckboxWidget('Sole (pressure)','Too hard','Too soft')),
        Padding(padding:EdgeInsets.fromLTRB(16,8,16,0),child:S2DCheckboxWidget('Sole (stiffness)','Too flexible','Too stiff')),
        Padding(padding:EdgeInsets.fromLTRB(16,8,16,0),child:S2DCheckboxWidget('Toe box','Too narrow','Too wide')),
        Padding(padding:EdgeInsets.fromLTRB(16,8,16,0),child:S2DCheckboxWidget('Upper','Too rigid','Too stretchy')),
        Padding(padding:EdgeInsets.fromLTRB(16,8,16,0),child:S2DCheckboxWidget('Weight','Too heavy','Too light')),
         Container(padding: EdgeInsets.fromLTRB(16,0,16,16), child:
         RichText(
             text: TextSpan(
                 style: TextStyle(color: HexColor('#222222'),
                     fontWeight: FontWeight.w500,
                     height:1.5,
                     fontFamily: 'Barlow',
                     fontSize: 20),
                 children: <InlineSpan>[
                   TextSpan(text: "Other"),
                   WidgetSpan(
                       alignment: PlaceholderAlignment.baseline,
                       baseline: TextBaseline.alphabetic,
                       child: SizedBox(height: 35)),
                   TextSpan(text: " (Please specify)",style:TextStyle(fontWeight: FontWeight.w400,
                       fontSize: 18,height:1.5)),
                 ]
             ))),
         Container(padding: EdgeInsets.fromLTRB(16.0,0,16,0),height:48, width:width,child:TextFormField(
          key: new Key('discomf_cause'),
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
            floatingLabelBehavior:FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.only(left: 24.0),
            //labelText: "Age",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: BorderSide(
                color: HexColor('#A5E0E5'),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: BorderSide(
                color: HexColor('#A5E0E5'),
                width: 2.0,
              ),
            ),
            hintText: "The discomfort comes from...",hintStyle: TextStyle(
            color: HexColor('969696'),fontSize: 16,fontWeight: FontWeight.w500, // Change background color for hint text
          ),),
          autocorrect: false,
          //validator: (val) =>
          //val.isEmpty
          //? 'can\'t be empty.'
          //: null,
          onChanged: (val) => Discomf_Cause = val,
        )),
         ]))),
         //if(trickyfit_checked)
         Padding(padding:EdgeInsets.only(top:16),child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
             onPressed: () async{
               var firebaseUser = FirebaseAuth.instance.currentUser;
               //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
               final firestoreInstance = FirebaseFirestore.instance;
               //final Map<String, dynamic> tempMap =values;
               //tempMap.removeWhere((String key, dynamic value)=> value==false);
               firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                   .update({"unlisted_tricky_fit":Discomf_Cause}).then((_) {
                 print("success!");
               });
               Navigator.push(
                 context,
                 SlideRoute(page: S2E(),duration: 600,direction: 'Left'),
               );},
             child: Container(padding: EdgeInsets.fromLTRB(16, 8, 8, 16), alignment:Alignment.bottomRight,
                 child: Text('NEXT',
                     style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
         ))
      ])
    ));


    //);
  }
}

class S2DCheckboxWidget extends StatefulWidget {
  final title,box1,box2;
  S2DCheckboxWidget(this.title,this.box1,this.box2);
  @override
  S2DCheckboxWidgetState createState() => S2DCheckboxWidgetState();
}

class S2DCheckboxWidgetState extends State<S2DCheckboxWidget> {
  bool box1_value = false, box2_value=false;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  //App widget tree
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(color: HexColor('#222222'),
                          fontWeight: FontWeight.w500,
                          height:1.5,
                          fontFamily: 'Barlow',
                          fontSize: 20), //TextStyle
                    ), //Text
                    SizedBox(height: 10),
                    Container(width:975,child:
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                         //SizedBox
                        Expanded(child:Text(
                          widget.box1,
                          style: TextStyle(color: HexColor('#222222'),
                              fontWeight: FontWeight.w400,
                              height:1.5,
                              fontFamily: 'Barlow',
                              fontSize: 18),
                        )), //Text
                        //SizedBox(width: 60), //SizedBox
                        /** Checkbox Widget **/
                        Checkbox(
                          value: this.box1_value,
                          activeColor: HexColor('00CED3'),
                          onChanged: (bool value) {
                            setState(() {
                              this.box1_value = value;
                            });
                            if(value)
                            firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                                .update({widget.title: widget.box1}).then((_) {
                              print("success!");
                              trickyfit_checked=true;
                            });
                            if(!value)
                              trickyfit_checked=false;
                          },
                         )
                        //Checkbox
                      ], //<Widget>[]
                    )), //Row
                    Row(
                      children: <Widget>[
                        //SizedBox
                        Expanded(child:Text(
                          widget.box2,
                          style: TextStyle(color: HexColor('#222222'),
                              fontWeight: FontWeight.w400,
                              height:1.5,
                              fontFamily: 'Barlow',
                              fontSize: 18),
                        )), //Text
                        //SizedBox(width: 10), //SizedBox
                        /** Checkbox Widget **/
                        Checkbox(
                          value: this.box2_value,
                          activeColor: HexColor('00CED3'),
                          onChanged: (bool value) {
                            setState(() {
                              this.box2_value = value;
                            });
                            if(value)
                            firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                                .update({widget.title: widget.box2}).then((_) {
                              print("success!");
                              trickyfit_checked=true;
                            });
                            if(!value)
                              trickyfit_checked=false;
                          },
                        ) //Checkbox
                      ], //<Widget>[]
                    ),
                  ],
                 //Column
               //SizedBox
            //Padding
           //Card
      //Center//Center//Scaffold
    ); //MaterialApp
  }
}



  class S1A1 extends StatefulWidget {
  @override
  S1A1State createState() => new S1A1State();
  }

  class S1A1State extends State {
  SingingCharacter selectedValue;
  //S1A1({Key key,this.selectedValue}) : super(key: key);
  //S1A1(this.selectedValue);
  //static const String _title = 'Flutter Code Sample';
  int val = -1;
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[

        Container(padding: EdgeInsets.fromLTRB(16,16,16,8), child:
        RichText(
            text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w500,
                    height:1.5,
                    fontFamily: 'Barlow',
                    fontSize: 20),
                children: <InlineSpan>[
                  TextSpan(text: "Location\n"),
                  WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: SizedBox(height: 35)),
                  TextSpan(text: "Are you located in the United States?",style:TextStyle(fontWeight: FontWeight.w400,
                      fontSize: 18,height:1.5)),
                ]
            ))),
        /*RadioButtonWidget(itemsList: [SingingCharacter.yes,SingingCharacter.no],
          defaultValue: SingingCharacter.no,
          onChanged: (value) {
            selectedValue = value;
            print(selectedValue);
          },),*/
        Container(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                    title: Text("Yes"),
                    leading: Transform.scale(
                      scale: 1.4,
                      child:Radio(
                        value: 1,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value;
                          });
                        },
                        activeColor: HexColor('00CED3'),

                      ),
                    )),
                ListTile(
                    title: Text("No"),
                    leading: Transform.scale(
                      scale: 1.4,
                      child:Radio(
                        value: 2,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value;
                          });
                        },
                        activeColor: HexColor('00CED3'),
                      ),
                    )),
              ],
            )),
        if (val!=-1)
        Expanded(child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
            onPressed: () async{
              /*var firebaseUser = FirebaseAuth.instance.currentUser;
              //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
              final firestoreInstance = FirebaseFirestore.instance;
              /*final Map<String, dynamic> tempMap =values;
               tempMap.removeWhere((String key, dynamic value)=> value==false);*/
               firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                   .update({"USBased": selectedValue}).then((_) {
                 print("success!");
               });*/
              Navigator.push(
                context,
                SlideRoute(page: val== 1? S1A2('New York','states'):S1A3(),duration: 600,direction: 'Left'),
              );},
            child: Container(padding: EdgeInsets.fromLTRB(16, 8, 8, 16), alignment:Alignment.bottomRight,
                child: Text('NEXT',
                    style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
        )
        )
      ])

    );
  }
}




class S1D0 extends StatefulWidget {
  //const S1D0({Key key}) : super(key: key);
  //SingingCharacter selectedValue;

  //S1A1({Key key,this.selectedValue}) : super(key: key);
  //S1D0(this.selectedValue);

  //static const String _title = 'Flutter Code Sample';
  @override
  S1D0State createState() => S1D0State();
}
  class S1D0State extends State<S1D0> {
    //SingingCharacter selectedValue;
    bool _value = false;
    int val = -1;
  @override
  Widget build(BuildContext context) {
    ;
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
              //onPressed: () => Navigator.pop(context)),
              onPressed: () =>Navigator.push(context, SlideRoute(page: S2C(),duration: 600,direction: 'Left'))),*/
          /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[

          Container(padding: EdgeInsets.fromLTRB(16,16,16,8), child:
          RichText(
              text: TextSpan(
                  style: TextStyle(color: HexColor('#222222'),
                      fontWeight: FontWeight.w500,
                      height:1.5,
                      fontFamily: 'Barlow',
                      fontSize: 20),
                  children: <InlineSpan>[
                    TextSpan(text: "Foot Pain\n",style: TextStyle(color: HexColor('#222222'),
                        fontWeight: FontWeight.w600,
                        height:1.5,
                        fontFamily: 'Barlow',
                        fontSize: 22),),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: SizedBox(height: 35)),
                    TextSpan(text: "Have you had pain, aching or stiffness in either of your feet, on most days in the past month?",style:TextStyle(fontWeight: FontWeight.w400,
                        fontSize: 18,height:1.5)),
                  ]
              ))),
          /*RadioButtonWidget(
            itemsList: [SingingCharacter.no,SingingCharacter.yes],
            defaultValue: SingingCharacter.no,
            onChanged: (value) {
              selectedValue = value;
            },
          ),*/
          Container(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Yes"),
                      leading: Transform.scale(
                        scale: 1.4,
                        child:Radio(
                          value: 1,
                          groupValue: val,
                          onChanged: (value) {
                            setState(() {
                              val = value;
                            });
                          },
                          activeColor: HexColor('00CED3'),

                        ),
                      )),
                  ListTile(
                    title: Text("No"),
                      leading: Transform.scale(
                        scale: 1.4,
                        child:Radio(
                          value: 2,
                          groupValue: val,
                          onChanged: (value) {
                            setState(() {
                              val = value;
                            });
                          },
                          activeColor: HexColor('00CED3'),
                        ),
                      )),
                ],
              )),
          if(val==1 || val==2)
          Expanded(child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
              onPressed: () {
                /*var firebaseUser = FirebaseAuth.instance.currentUser;
                //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
                final firestoreInstance = FirebaseFirestore.instance;
                //final Map<String, dynamic> tempMap =values;
               //tempMap.removeWhere((String key, dynamic value)=> value==false);
               firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                   .update({"Pain": val}).then((_) {
                 print("success!");
               });*/
                Navigator.push(
                  context,
                  SlideRoute(page: val==1? S1D1():S1E(),duration: 600,direction: 'Left'),
                );},
              child: Container(padding: EdgeInsets.fromLTRB(16, 8, 8, 16), alignment:Alignment.bottomRight,
                  child: Text('NEXT',
                      style: new TextStyle(fontFamily: 'Barlow', letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
          )
          )
        ])

    );
  }
}

enum SingingCharacter { yes, no }

class RadioButtonWidget extends StatefulWidget {
  final ValueChanged<SingingCharacter> onChanged;
  SingingCharacter defaultValue, selectedValue;
  List<SingingCharacter> itemsList;
  RadioButtonWidget({Key key,this.itemsList,
    this.defaultValue,
    this.onChanged}) : super(key: key);

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  SingingCharacter _character = SingingCharacter.yes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Theme(
                //here change to your color
                data: ThemeData(unselectedWidgetColor: HexColor('00CED3'),
              ), // <-- your color
          child: ListTile(
              title: const Text('Yes'),
              leading: Transform.scale(
              scale: 1.3,child: Radio<SingingCharacter>(
            value: SingingCharacter.yes,
            activeColor: HexColor("00CED3"),
            groupValue: _character,
            onChanged: (SingingCharacter value) {
              setState(() {
                _character = value;
              });
              widget.onChanged(value);
            },
          )))),

        Theme(
          //here change to your color
          data: ThemeData(unselectedWidgetColor: HexColor('00CED3'),
          ),child: ListTile(
          title: const Text('No'),
          leading:Transform.scale(
            scale: 1.3,child:
             Radio<SingingCharacter>(
            value: SingingCharacter.no,
            activeColor: HexColor("00CED3"),
            groupValue: _character,
            onChanged: (SingingCharacter value) {
              setState(() {
                _character = value;
              });
              widget.onChanged(value);
            },
          ),
        ))),
      ],
    );
  }
}
String ddValue;
class LocationMenu extends StatefulWidget {
  LocationMenu(this.dropdownValue, this.type);
  final String dropdownValue, type;

  @override
  _LocationMenuState createState() => new _LocationMenuState();
}

class _LocationMenuState extends State<LocationMenu> {
  //String ddValue = 'Select state...';

  @override
  Widget build(BuildContext context) {

    //String ddvalue=widget.dropdownValue;
    //var itemlist = widget.type=='states'? []:[];
    return Container(padding:EdgeInsets.fromLTRB(16,0,8,0),
        width: 328,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(width: 1,color: HexColor('00CED3'),style: BorderStyle.solid),
        ),
        child:
     DropdownButton<String>(
      value: ddValue,
      //icon: const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.teal),
      //elevation: 16,
       isExpanded: true,
      iconSize: 38,
      iconEnabledColor: HexColor('00CED3'),
      style: TextStyle(color: HexColor('#222222'),
          fontWeight: FontWeight.w400,
          //height:,
          fontFamily: 'Barlow',
          fontSize: 18),
      underline: Container(
        height: 0,
        color: Colors.white,
      ),

      onChanged: (String newValue) {
        setState(() {
          ddValue = newValue;
        });
      },

      items: <String> ['Select state...','Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Washington DC', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming']
            .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
       hint:Text('Select state...')
     )
    );
  }
}




  class S1A2 extends StatefulWidget {
  S1A2(this.dropdownValue, this.type);
  final String dropdownValue, type;

  @override
  S1A2State createState() => new S1A2State();
  }

  class S1A2State extends State<S1A2> {
  //static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    String state;
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[

          Container(padding: EdgeInsets.fromLTRB(16,16,16,8), child:
          RichText(
              text: TextSpan(
                  style: TextStyle(color: HexColor('#222222'),
                      fontWeight: FontWeight.w600,
                      height:1.5,
                      fontFamily: 'Barlow',
                      fontSize: 22),
                  children: <InlineSpan>[
                    TextSpan(text: "Location\n"),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: SizedBox(height: 35)),
                    TextSpan(text: "In which state do you live?",style:TextStyle(fontWeight: FontWeight.w400,
                        fontSize: 18,height:1.5)),
                  ]
              ))),
          Padding(padding:EdgeInsets.fromLTRB(16,8,0,0),child:LocationMenu('New York','states')),
          //if(ddValue!='Select state...')
          Expanded(child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
              onPressed: () async{
                print(ddValue);
                var firebaseUser = FirebaseAuth.instance.currentUser;
                //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
                final firestoreInstance = FirebaseFirestore.instance;
                //final Map<String, dynamic> tempMap =values;
               //tempMap.removeWhere((String key, dynamic value)=> value==false);*/
               firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                   .update({"State": ddValue}).then((_) {
                 print("success!");
               });
                Navigator.push(
                  context,
                  SlideRoute(page: S1BGender(),duration: 600,direction: 'Left'),
                );},
              child: Container(padding: EdgeInsets.fromLTRB(16, 8, 8, 16), alignment:Alignment.bottomRight,
                  child: Text('NEXT',
                      style: new TextStyle(fontFamily: 'Barlow', letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
          )
          )
        ])

    );
  }
}


  class S1A3 extends StatefulWidget {

  @override
  S1A3State createState() => S1A3State();
  }

  class S1A3State extends State<S1A3> {
  //static const String _title = 'Flutter Code Sample';
  final GlobalKey<FormState> _countryformKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState form = _countryformKey.currentState;
    if (form.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    String country;
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[

          Container(padding: EdgeInsets.fromLTRB(16,16,16,8), child:
          RichText(
              text: TextSpan(
                  style: TextStyle(color: HexColor('#222222'),
                      fontWeight: FontWeight.w600,
                      height:1.5,
                      fontFamily: 'Barlow',
                      fontSize: 22),
                  children: <InlineSpan>[
                    TextSpan(text: "Location\n"),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: SizedBox(height: 35)),
                    TextSpan(text: "In which country do you live?",style:TextStyle(fontWeight: FontWeight.w400,
                        fontSize: 18,height:1.5)),
                  ]
              ))),
          Container(width:375,padding:EdgeInsets.fromLTRB(16,8,16,0),child:
          TextFormField(
            key: _countryformKey,//new Key('country'),
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
                floatingLabelBehavior:FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(left: 24.0),
                //labelText: "Age",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.0),
                  borderSide: BorderSide(
                    color: HexColor('#A5E0E5'),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.0),
                  borderSide: BorderSide(
                    color: HexColor('#A5E0E5'),
                    width: 2.0,
                  ),
                ),
                hintText: 'I live in...'),
            autocorrect: false,
            validator: (val) =>
            val.isEmpty
            ? 'can\'t be empty.'
            : null,
            onChanged: (val) => country = val,
          )),
          Expanded(child:SizedBox()),
          FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
              onPressed: () async{
                //validateAndSave();
                var firebaseUser = FirebaseAuth.instance.currentUser;
                //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
                final firestoreInstance = FirebaseFirestore.instance;
                //final Map<String, dynamic> tempMap =values;
                //tempMap.removeWhere((String key, dynamic value)=> value==false);
                firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                    .update({"Country": country}).then((_) {
                  print("success!");
                });
                Navigator.push(
                  context,
                  SlideRoute(page: S2B(),duration: 600,direction: 'Left'),
                );},
              child: Container(padding: EdgeInsets.fromLTRB(16, 8, 8, 16), alignment:Alignment.bottomRight,
                  child: Text('NEXT',
                      style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
          )
        ])

    );
  }
}

class S2C extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
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
                onPressed: () => Navigator.pop(context)),*/
              //onPressed: () =>Navigator.push(context, SlideRoute(page: S1BGender(),duration: 600,direction: 'Left'))),
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),
          body:
          BackgroundCheckboxWidget(),

    );
    //);
  }
}

class BackgroundCheckboxWidget extends StatefulWidget {
  @override
  BackgroundCheckboxWidgetState createState() => new BackgroundCheckboxWidgetState();
}

class BackgroundCheckboxWidgetState extends State {
  var _controller = ScrollController();
  bool atEnd=false;

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        atEnd=true;
      }
    });
  }

  Map<String, bool> values = {
    'American Indian or Alaska Native': false,
    'Asian - East Asian': false,
    'Asian - South Asian': false,
    'Asian - Southeast Asian': false,
    'Black or African American': false,
    'Hispanic, Latino, or Spanish origin': false,
    'Middle Eastern or North African': false,
    'Native Hawaiian or other Pacific Islander': false,
    'White': false,
    'Not Listed': false,
  };

  var tmpArray = [];
  int count=0;

  getCheckboxItems(){
    tmpArray.clear();
    values.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.

  }

  @override
  Widget build(BuildContext context) {
    return Column (children: <Widget>[
      Container(padding: EdgeInsets.all(16), child:
      RichText(
          text: TextSpan(
              style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w600,
                  height:1.4,
                  fontFamily: 'Barlow',
                  fontSize: 22),
              children: <TextSpan>[
                TextSpan(text: "Background"),
                TextSpan(text: "\n\nDo you describe yourself as any of the following? Please check all that apply.",style:TextStyle(fontWeight: FontWeight.w400,
                    fontSize: 18)),
                //TextSpan(text: "\n\nThis information is optional and will not be shared with any third parties.",style:TextStyle(fontWeight: FontWeight.w700,
                    //fontSize: 16, color: HexColor("9B9B9B"))),
              ]
          ))),
    Expanded(child:Container(height:310,child:RawScrollbar(isAlwaysShown: true,thumbColor: HexColor("#00CED3"),
    child:
         ListView(controller: _controller,
          children: values.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key,style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w400,
                  height:1.4,
                  fontFamily: 'Barlow',
                  fontSize: 18),),
              value: values[key],
              activeColor: HexColor('#00CED3'),
              checkColor: Colors.white,
              onChanged: (bool value) {
                /*setState(() {
                  values[key] = value;
                });*/
                setState(() {
                  if(count<10) {
                    values[key] = value;
                    values[key]==true ? count+=1:count-=1;
                  }else{
                    if(values[key] == true)  {
                      values[key] = value;
                      count -= 1;
                    }else{

                    }
                  }
                });
              },
            );
          }).toList(),
        ),
      ))),
      //if(atEnd)
      if(count>0)
      FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onPressed: () async{
            var firebaseUser = FirebaseAuth.instance.currentUser;
            //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
            final firestoreInstance = FirebaseFirestore.instance;
            //final Map<String, dynamic> tempMap =values;
            //tempMap.removeWhere((String key, dynamic value)=> value==false);
            getCheckboxItems();
            firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                .update({"ethnicity": tmpArray}).then((_) {
              print("success!");
            });
            Navigator.push(
              context,
              SlideRoute(page: S1D0(),duration: 600,direction: 'Left'),
            );},
          child: Container(padding: EdgeInsets.fromLTRB(16, 0, 0, 8), alignment:Alignment.bottomRight,
              child: Text('NEXT',
                  style: new TextStyle(fontFamily: 'Barlow', letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
      ),
    ]);
  }
}

class S2A extends StatelessWidget {
  String age, weight, height_ft, height_in;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0),
                child: Text(
                    "Iambic Survey", style: TextStyle(fontWeight: FontWeight.w600,
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),
          body:
          Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Container(padding: EdgeInsets.all(16), child:
               RichText(
                  text: TextSpan(
                      style: TextStyle(color: HexColor('#222222'),
                          fontWeight: FontWeight.w500,
                          height:1.4,
                          fontFamily: 'Barlow',
                          fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(text: "Additional Information\n\n"),
                        TextSpan(text: "In order to improve fit accuracy, we need some additional information.",style:TextStyle(fontWeight: FontWeight.w400,
                            fontSize: 16)),
                        TextSpan(text: " We will not share this data with any third parties.",style:TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 16, color: HexColor("9B9B9B"))),
                      ]
                  ))),

              //Container(padding: EdgeInsets.all(8.0),child:Text("Age")),
             //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Age')),
             Row(children:[
               Container(padding: EdgeInsets.fromLTRB(16.0,8,16,0),width:124,child:TextFormField(
              key: new Key('age'),
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
              floatingLabelBehavior:FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.only(left: 24.0),
              labelText: "Age",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48.0),
                borderSide: BorderSide(
                  color: HexColor('#A5E0E5'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48.0),
                borderSide: BorderSide(
                  color: HexColor('#A5E0E5'),
                  width: 2.0,
                ),
              ),
              hintText: ''),
              autocorrect: false,
              //validator: (val) =>
              //val.isEmpty
              //? 'can\'t be empty.'
              //: null,
              onChanged: (val) => age = val,
           )),
            SizedBox(height:10),
            //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Weight')),
            Container(padding: EdgeInsets.fromLTRB(16.0,8,16,0),width:124,child:TextFormField(
              key: new Key('weight'),
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  floatingLabelBehavior:FloatingLabelBehavior.always,
                  contentPadding: const EdgeInsets.only(left: 24.0),
                  labelText: "Weight",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.0),
                    borderSide: BorderSide(
                      color: HexColor('#A5E0E5'),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.0),
                    borderSide: BorderSide(
                      color: HexColor('#A5E0E5'),
                      width: 2.0,
                    ),
                  ),
                  hintText: 'lb'),
              autocorrect: false,
              //validator: (val) =>
              //val.isEmpty
              //    ? 'can\'t be empty.'
              //    : null,
              onChanged: (val) => weight = val,
            )),
            ]),
            SizedBox(height:10),
            //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Height')),
            Row(children:[
              Container(padding: EdgeInsets.fromLTRB(16.0,8,16,0),width:124,child:TextFormField(
              key: new Key('height'),
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  floatingLabelBehavior:FloatingLabelBehavior.always,
                  contentPadding: const EdgeInsets.only(left: 24.0),
                  labelText: "Height",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.0),
                    borderSide: BorderSide(
                      color: HexColor('#A5E0E5'),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.0),
                    borderSide: BorderSide(
                      color: HexColor('#A5E0E5'),
                      width: 2.0,
                    ),
                  ),
                  hintText: 'ft'),
              autocorrect: false,
              //validator: (val) =>
              //val.isEmpty
              //    ? 'can\'t be empty.'
              //    : null,
              onChanged: (val) => height_ft = val,
            )),
              Container(padding: EdgeInsets.fromLTRB(16.0,8,16,0),width:124,child:TextFormField(
                key: new Key('height'),
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 24.0),
                    //labelText: "Height",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.0),
                      borderSide: BorderSide(
                        color: HexColor('#A5E0E5'),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.0),
                      borderSide: BorderSide(
                        color: HexColor('#A5E0E5'),
                        width: 2.0,
                      ),
                    ),
                    hintText: 'in'),
                autocorrect: false,
                validator: (val) =>
                val.isEmpty
                    ? 'can\'t be empty.'
                    : null,
                onChanged: (val) => height_in = val,
              )),
            ]),
            Expanded(child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () async{
                  var firebaseUser = FirebaseAuth.instance.currentUser;
                  //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
                  final firestoreInstance = FirebaseFirestore.instance;
                  if(height_ft!=null && height_in!=null)
                  firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                      .update({"age": age,"Weight": weight, "Height":height_ft+height_in}).then((_) {
                    print("success!");
                  });
                  Navigator.push(
                    context,
                    SlideRoute(page: S2B(),duration: 600,direction: 'Left'),
                  );},
                child: Container(padding: EdgeInsets.fromLTRB(16, 16, 16, 16), alignment:Alignment.bottomRight,
                    child: Text('NEXT',
                        style: new TextStyle(fontSize: 16.0, color: HexColor('#00CED3'))))
            )),
          ]),

    );
    //);
  }
}

enum FormType {
  Age,
  Weight,
  Height,
}

class S1A0 extends StatefulWidget {

  @override
  S1A0State createState() => S1A0State();
}

class S1A0State extends State<S1A0> {

  final GlobalKey<FormState> _ageformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _weightformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _heightformKey = GlobalKey<FormState>();
  bool validateStructure(String value){
    //pattern for password with at least one capital letter and number and 6 characters
    //String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String pattern = r'[0-9]';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void validateAndSave() {
    final FormState ageform = _ageformKey.currentState;
    final FormState weightform = _weightformKey.currentState;
    final FormState heightform = _heightformKey.currentState;
    if (ageform.validate()&&weightform.validate()&&heightform.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    String age, weight, height_ft, height_in;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Center(//Align(alignment: Alignment(-0.25, 0),
            child: Text(
                "Iambic Survey", style: TextStyle(fontWeight: FontWeight.w600,
                //fontStyle: FontStyle.italic,
                fontFamily: 'Barlow',
                fontSize: 24, color: HexColor('#222222')))),
        backgroundColor: HexColor('#FFC40F'),
        //centerTitle: true,
        /*: IconButton(
            icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
            //onPressed:() => Navigator.pop(context, false),
            onPressed: () => Navigator.pop(context)),*/
        /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Expanded(child:ListView(children: <Widget>[
        Container(padding: EdgeInsets.all(16), child:
        RichText(
            text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height:1.4,
                    fontFamily: 'Barlow',
                    fontSize: 22),
                children: <InlineSpan>[
                  TextSpan(text: "Profile\n"),
                  WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: SizedBox(height: 35)),
                  TextSpan(text: "Let’s start with some general information. ",style:TextStyle(fontWeight: FontWeight.w400,
                      fontSize: 18,height:1.5)),
                ]
            ))),

        //Container(padding: EdgeInsets.all(8.0),child:Text("Age")),
        //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Age')),
        Form(
        key: _ageformKey,
        child: Row(children:[
          Container(padding: EdgeInsets.fromLTRB(16.0,8,16,0),width:156,child:TextFormField(
            key: new Key('age'),
            //key: _formKey,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
                floatingLabelBehavior:FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(left: 24.0),
                labelText: "Age",
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 20, color: HexColor('#222222')),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.0),
                  borderSide: BorderSide(
                    color: HexColor('#A5E0E5'),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.0),
                  borderSide: BorderSide(
                    color: HexColor('#A5E0E5'),
                    width: 2.0,
                  ),
                ),
                hintText: ''),
            autocorrect: false,
            validator: (val) =>
            val.isEmpty
                ? 'can\'t be empty.'
                : validateStructure(val) ? null:'must be a number!',
            onChanged: (val) => age = val,
            //onSaved: (val) => age = val,
          )),
          //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Weight')),
        ])),
        SizedBox(height:20),
    Form(
    key: _weightformKey,
    child:Row(children:[
        Container(padding: EdgeInsets.fromLTRB(16.0,8,16,0),width:156,child:TextFormField(
          key: new Key('weight'),
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(
              floatingLabelBehavior:FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.only(left: 24.0),
              labelText: "Weight",
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 20, color: HexColor('#222222')),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48.0),
                borderSide: BorderSide(
                  color: HexColor('#A5E0E5'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48.0),
                borderSide: BorderSide(
                  color: HexColor('#A5E0E5'),
                  width: 2.0,
                ),
              ),
              hintText: 'lb'),
          autocorrect: false,
          validator: (val) =>
          val.isEmpty
              ? 'can\'t be empty.'
              : validateStructure(val) ? null:'must be a number!',
          onChanged: (val) => weight = val,
        )),
        ])),
        SizedBox(height:20),
        //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Height')),
    Form(
    key: _heightformKey,
    child:Row(children:[
          Container(padding: EdgeInsets.fromLTRB(16.0,8,16,0),width:156,child:TextFormField(
            key: new Key('height'),
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
                floatingLabelBehavior:FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(left: 24.0),
                labelText: "Height",
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 20, color: HexColor('#222222')),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.0),
                  borderSide: BorderSide(
                    color: HexColor('#A5E0E5'),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.0),
                  borderSide: BorderSide(
                    color: HexColor('#A5E0E5'),
                    width: 2.0,
                  ),
                ),
                hintText: 'ft'),
            autocorrect: false,
            validator: (val) =>
            val.isEmpty
                ? 'can\'t be empty.'
                : validateStructure(val) ? null:'must be a number!',
            onChanged: (val) => height_ft = val,
          )),
          Container(padding: EdgeInsets.fromLTRB(16.0,8,16,0),width:156,child:TextFormField(
            key: new Key('height'),
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
                contentPadding: const EdgeInsets.only(left: 24.0),
                //labelText: "Height",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.0),
                  borderSide: BorderSide(
                    color: HexColor('#A5E0E5'),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.0),
                  borderSide: BorderSide(
                    color: HexColor('#A5E0E5'),
                    width: 2.0,
                  ),
                ),
                hintText: 'in'),
            autocorrect: false,
            validator: (val) =>
            val.isEmpty
                ? 'can\'t be empty.'
                : validateStructure(val) ? null:'must be a number!',
            onChanged: (val) => height_in = val,
          )),
        ])),
        FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
            onPressed: () async{
              Navigator.push(
                context,
                SlideRoute(page: T4A('Right'),duration: 600,direction: 'Left'),
              );},
            child: Container(padding: EdgeInsets.fromLTRB(16, 20, 8, 16), alignment:Alignment.bottomLeft,
                child: Text('I’ve already taken the survey.',
                    style: new TextStyle(decoration: TextDecoration.underline,fontFamily: 'Barlow',  fontWeight: FontWeight.w600, letterSpacing: 1.5, fontSize: 18.0, color: HexColor('#00CED3'))))
        ),
        ])
      ),

        FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
            onPressed: () async{
              validateAndSave();
              var firebaseUser = FirebaseAuth.instance.currentUser;
              //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
              final firestoreInstance = FirebaseFirestore.instance;
              print(firebaseUser.uid);
              //if(validateAndSave())
                /*firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                    .update({"age": age,"Weight": weight, "Height":height_ft+height_in}).then((_) {
                  print("success!");
                });*/
                firestoreInstance
                    .collection('userdata')
                    .doc(firebaseUser.uid)
                    .update({
                  "age": age,"Weight(user)": weight, "Height":height_ft+height_in
                });
              Navigator.push(
                context,
                SlideRoute(page: S1A1(),duration: 600,direction: 'Left'),
              );},
            child: Container(padding: EdgeInsets.fromLTRB(16, 16, 8, 16), alignment:Alignment.bottomRight,
                child: Text('NEXT',
                    style: new TextStyle(fontFamily: 'Barlow',  fontWeight: FontWeight.w700, letterSpacing: 1.5, fontSize: 16.0, color: HexColor('#00CED3'))))
        ),
      ]),

    );
    //);
  }
}

class S2B2 extends StatelessWidget {
  String size_txt,size_rating;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Center(//Align(alignment: Alignment(-0.25, 0),
            child: Text(
                "Iambic Survey", style: TextStyle(fontWeight: FontWeight.w600,
                //fontStyle: FontStyle.italic,
                fontFamily: 'Barlow',
                fontSize: 24, color: HexColor('#222222')))),
        backgroundColor: HexColor('#FFC40F'),
        //centerTitle: true,
        /*leading: IconButton(
            icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
            //onPressed:() => Navigator.pop(context, false),
            onPressed: () =>Navigator.push(context, SlideRoute(page: S2A2(),duration: 600,direction: 'Left'))),*/
            //onPressed: () => Navigator.pop(context)),
        /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

        Container(padding:EdgeInsets.fromLTRB(16,16,0,16),child:Text("Your Favorite Pair",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w600,
            height:1.0,
            fontFamily: 'Barlow',
            fontSize: 22),)),
        Container(padding:EdgeInsets.fromLTRB(16,8,0,16),child:Text("Rate the fit?",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w500,
            height:1.0,
            fontFamily: 'Barlow',
            fontSize: 20),)),
        //Container(padding: EdgeInsets.all(8.0),child:Text("Age")),
        //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Age')),
        Center(child:rating('Poor','Average','Excellent','favorite_pair_fit')),
        //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Height')),
        Container(padding:EdgeInsets.fromLTRB(16,0,0,16),child:Text("What size do you wear in that model?",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w500,
            height:1.5,
            fontFamily: 'Barlow',
            fontSize: 20),)),
        Container(padding: EdgeInsets.fromLTRB(16,0,16,0),width:375,child:TextFormField(
          key: new Key('size_rating'),
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
              floatingLabelBehavior:FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.only(left: 24.0),
              //labelText: "Age",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48.0),
                borderSide: BorderSide(
                  color: HexColor('#A5E0E5'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48.0),
                borderSide: BorderSide(
                  color: HexColor('#A5E0E5'),
                  width: 2.0,
                ),
              ),
              hintText: 'I wear...'),
          autocorrect: false,
          //validator: (val) =>
          //val.isEmpty
          //? 'can\'t be empty.'
          //: null,
          onChanged: (val) => size_rating = val,
        )),
        Expanded(child:SizedBox()),
        FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
            onPressed: () async{
              var firebaseUser = FirebaseAuth.instance.currentUser;
              //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
              final firestoreInstance = FirebaseFirestore.instance;
              if(size_rating!=null)
                firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                    .update({"favorite_size": size_rating}).then((_) {
                  print("success!");
                });
              Navigator.push(
                context,
                SlideRoute(page: S2C2(),duration: 600,direction: 'Left'),
              );},
            child: Container(padding: EdgeInsets.fromLTRB(16, 16, 8, 16), alignment:Alignment.bottomRight,
                child: Text('NEXT',
                    style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
        ),

      ]),
    );
    //);
  }
}

class S2C2 extends StatelessWidget {
  String size_txt,size_rating;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Center(//Align(alignment: Alignment(-0.25, 0),
            child: Text(
                "Iambic Survey", style: TextStyle(fontWeight: FontWeight.w600,
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

        Container(padding:EdgeInsets.fromLTRB(16,16,0,16),child:Text("Your Favorite Pair",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w600,
            height:1.0,
            fontFamily: 'Barlow',
            fontSize: 22),)),
        Container(padding:EdgeInsets.fromLTRB(16,0,0,16),child:Text("How stylish do you find them?",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w500,
            height:1.0,
            fontFamily: 'Barlow',
            fontSize: 20),)),
        //Container(padding: EdgeInsets.all(8.0),child:Text("Age")),
        //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Age')),
        Center(child:rating('Very unstylish','Average','Very stylish','stylish_self')),
        //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Height')),
        Container(padding:EdgeInsets.fromLTRB(16,8,0,16),child:Text("How stylish do others find them?",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w500,
            height:1.5,
            fontFamily: 'Barlow',
            fontSize: 20),)),
        Center(child:rating('Very unstylish','Average','Very stylish','stylish_others')),
        Expanded(child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
            onPressed: () async{
              Navigator.push(
                context,
                SlideRoute(page: S2D(),duration: 600,direction: 'Left'),
              );},
            child: Container(padding: EdgeInsets.fromLTRB(16, 16, 16, 16), alignment:Alignment.bottomRight,
                child: Text('NEXT',
                    style: new TextStyle(fontFamily: 'Barlow', letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
        )),
      ]),


    );
    //);
  }
}

class S2E extends StatelessWidget {
  String size_txt,size_rating;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Center(//Align(alignment: Alignment(-0.25, 0),
            child: Text(
                "Iambic Survey", style: TextStyle(fontWeight: FontWeight.w600,
                //fontStyle: FontStyle.italic,
                fontFamily: 'Barlow',
                fontSize: 24, color: HexColor('#222222')))),
        backgroundColor: HexColor('#FFC40F'),
        //centerTitle: true,
        /*leading: IconButton(
            icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
            //onPressed:() => Navigator.pop(context, false),
            onPressed: () =>Navigator.push(context, SlideRoute(page: S2D(),duration: 600,direction: 'Left'))),*/
            //onPressed: () => Navigator.pop(context)),
        /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

        Container(padding:EdgeInsets.fromLTRB(16,16,0,16),child:Text("Your Shoe Preferences",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w600,
            height:1.0,
            fontFamily: 'Barlow',
            fontSize: 22),)),
        Container(padding:EdgeInsets.fromLTRB(16,0,0,16),child:Text("Please indicate your preferences for the following shoe characteristics.",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w400,
            height:1.5,
            fontFamily: 'Barlow',
            fontSize: 18),)),
        Container(padding:EdgeInsets.fromLTRB(16,0,0,16),child:Text("Cushioning",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w500,
            height:1.5,
            fontFamily: 'Barlow',
            fontSize: 20),)),
        //Container(padding: EdgeInsets.all(8.0),child:Text("Age")),
        //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Age')),
        Center(child:rating('Firm','Neutral','Soft','cushioning')),
        //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Height')),
        Container(padding:EdgeInsets.fromLTRB(16,8,0,16),child:Text("Fit tightness",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w500,
            height:1.5,
            fontFamily: 'Barlow',
            fontSize: 20),)),
        Center(child:rating('Loose','Neutral','Snug','tightness')),
        Expanded(child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
            onPressed: () async{
              Navigator.push(
                context,
                SlideRoute(page: S2F(),duration: 600,direction: 'Left'),
              );},
            child: Container(padding: EdgeInsets.fromLTRB(16, 16, 16, 16), alignment:Alignment.bottomRight,
                child: Text('NEXT',
                    style: new TextStyle(fontFamily: 'Barlow', letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
        )),
      ]),


    );
    //);
  }
}

class S2F extends StatelessWidget {
  String size_txt,size_rating;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Center(//Align(alignment: Alignment(-0.25, 0),
            child: Text(
                "Iambic Survey", style: TextStyle(fontWeight: FontWeight.w600,
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
      ),
      body:
      Column (crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

        Container(padding:EdgeInsets.fromLTRB(16,16,0,16),child:Text("Your Shoe Preferences",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w600,
            height:1.0,
            fontFamily: 'Barlow',
            fontSize: 22),)),

        Container(padding:EdgeInsets.fromLTRB(16,0,0,16),child:Text("Flexibility",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w500,
            height:1.0,
            fontFamily: 'Barlow',
            fontSize: 20),)),
        //Container(padding: EdgeInsets.all(8.0),child:Text("Age")),
        //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Age')),
        Center(child:rating('Rigid','Neutral','Flexible','flexibility')),
        //Container(padding: EdgeInsets.fromLTRB(16.0,8,16,8),child:Text('Height')),
        Container(padding:EdgeInsets.fromLTRB(16,8,0,16),child:Text("Temperature",style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w500,
            height:1.5,
            fontFamily: 'Barlow',
            fontSize: 20),)),
        Center(child:rating('Cool','Neutral','Warm','temperature')),
        Expanded(child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
            onPressed: () async{
              Navigator.push(
                context,
                //SlideRoute(page: T2B(),duration: 600,direction: 'Left'),
                  SlideRoute(page: T2B(),duration: 600,direction: 'Left'),
              );},
            child: Container(padding: EdgeInsets.fromLTRB(16, 16, 16, 16), alignment:Alignment.bottomRight,
                child: Text('NEXT',
                    style: new TextStyle(fontFamily: 'Barlow', letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16.0, color: HexColor('#00CED3'))))
        )),
      ]),


    );
    //);
  }
}

/*class S4A extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Align(alignment: Alignment(-0.25, 0),
                child: Text(
                    "Videos", style: TextStyle(fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24, color: HexColor('#222222')))),
            backgroundColor: HexColor('#FFC40F'),
            //centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                onPressed:() => Navigator.push(context, SlideRoute(page: S2C(),duration: 600,direction: 'Left'))),
                //onPressed: () => Navigator.pop(context)),
            /*actions: <Widget>[
              InkWell(
                  onTap: () async{
                    await _firebaseAuth.signOut();
                    //await googleSignIn.signOut();
                    Navigator.push(
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),
          body:
          Column(children:[
            Container(
                padding: EdgeInsets.only(left:16),
                width: double.infinity,
                height:60,
                color:HexColor('#FFC40F') ,
                child:
                Text("What You'll Need",style:TextStyle(
                    color: HexColor('#222222'),
                    //Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 32))),
            menuitem('US Letter Paper', '8.5" X 11" smooth, blank, white paper', '(no wrinkles!)', 'assets/images/icon_setup1_paper.png'),
            Divider(color: HexColor('#E0E0E0')),
            menuitem('Lighting', 'Bright, even lighting', '(no heavy shadows!)','assets/images/icon_setup2_lighting.png'),
            Divider(color: HexColor('#E0E0E0')),
            menuitem('Flat Surface', 'Hard, dark floor', '(no carpet!)', 'assets/images/icon_setup3_surface.png'),
            Divider(color: HexColor('#E0E0E0')),
            menuitem('Bare feet & ankles', 'Roll up clothing above your ankles', '(no socks!)', 'assets/images/icon_setup4_barefeet.png'),
            //Divider(color: Colors.black),
            Expanded(child:Align(alignment: FractionalOffset.bottomRight, child: FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: (){
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => S4B('Left')),
                    SlideRoute(page: S4B('Right'),duration: 600,direction: 'Left'),
                  );},
                child: Text('GOT IT', style: new TextStyle(fontSize: 17.0, color: HexColor('#00CED3')))))
            )
          ]

          ),

    );
    //);
  }
}*/

Widget menuitem(String txt1, String txt2, String txt3, String imagepath) {
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

      FittedBox(fit: BoxFit.fitWidth, child: Text(txt1, style:TextStyle(
          color: HexColor('#222222'),//Colors.grey[800],
          fontWeight: FontWeight.w600,
          //fontStyle: FontStyle.italic,
          fontFamily: 'Barlow',
          fontSize: 16))),
      FittedBox(fit: BoxFit.fitWidth, child:Text(txt2,style:TextStyle(
          color: HexColor('#222222'),//Colors.grey[800],
          fontWeight: FontWeight.w400,
          //fontStyle: FontStyle.italic,
          fontFamily: 'Barlow',
          fontSize: 16))),
      FittedBox(fit: BoxFit.fitWidth, child:Text(txt3,style:TextStyle(
          color: HexColor('#969696'),//Colors.grey[800],
          fontWeight: FontWeight.w400,
          //fontStyle: FontStyle.italic,
          fontFamily: 'Barlow',
          fontSize: 16))),
    ],
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal:12.0),
  );
}

class blobUrlPlayer extends StatefulWidget {
  final String source;

  blobUrlPlayer({Key key, @required this.source}) : super(key: key);

  @override
  _blobUrlPlayerState createState() => _blobUrlPlayerState();
}
class _blobUrlPlayerState extends State<blobUrlPlayer> {

  final videoElement = VideoElement();

  @override
  void initState() {
    super.initState();
    videoElement
      ..src = widget.source
      ..autoplay = true
      ..controls = true
      ..style.border = 'none'
      ..style.height = '100%'
      ..style.width = '100%';

    // Allows Safari iOS to play the video inline
    videoElement.setAttribute('playsinline', 'true');

    // Set autoplay to false since most browsers won't autoplay a video unless it is muted
    videoElement.setAttribute('autoplay', 'true');

    //videoElement.play();

    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        widget.source, (int viewId) => videoElement);
  }

  @override
  Widget build(BuildContext context) {
    return
        HtmlElementView(
        key: UniqueKey(),
      viewType: widget.source,
     );
  }
}

class S4B extends StatelessWidget {
  String side;
  bool new_vidset;
  S4B(this.side,this.new_vidset);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0),
                child: Text(
                    "Videos", style: TextStyle(fontWeight: FontWeight.w600,
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children:[
            Container(
                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                width: double.infinity,
                height:60,
                color:HexColor('#FFC40F') ,
                child:
                Text("What You'll Do",style:TextStyle(
                    color: HexColor('#222222'),
                    //Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 32))),
            //SizedBox(height:10),
            side =='Right'? Container(width: 0.8*width,child: Image.asset('assets/images/RotateCamera.gif')):Container(width: 0.8*width,child: Image.asset('assets/images/RotateCamera.gif')),
            Container(padding: EdgeInsets.fromLTRB(16, 16, 16, 16), child:
             RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w500,
                    height:1.4,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: "Watch the video above for a demonstration of how to capture your"),
                  TextSpan(
                      text: " $side foot.",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  TextSpan(text: " Instructions follow on the next screen.",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                ],
              ),
            )),
            //SizedBox(height: 20),
            Expanded(child:Align(alignment: FractionalOffset.bottomRight, child: FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: (){
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => S4D(side,'1')),
                    SlideRoute(page: S4(side,new_vidset),duration: 600,direction: 'Left'),
                  );},
                child: Text('GOT IT', style: new TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w600,fontSize: 17.0, color: HexColor('#00CED3')))))
            )

          ]

          ),
    );
    //);
  }
}

class S4D extends StatelessWidget {
  final String side,stepnum;
  S4D(this.side,this.stepnum);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children:[
      Container(
          color:Colors.black,
          width: double.infinity,
          height: double.infinity,
          child: Opacity(opacity:0.25,child:Image.asset('assets/images/S4C.png', fit: BoxFit.fill))),
     Positioned(top:30,child: Container(width: 360,padding: EdgeInsets.fromLTRB(100, 16, 32, 16),
         child:Text("Video: $side Foot",style: TextStyle(color: HexColor('#FFFFFF'),
          fontWeight: FontWeight.w600,
          fontFamily: 'Barlow',
          fontSize: 24)))),
     Positioned(top:70,child:Container(width: 360,padding: EdgeInsets.fromLTRB(16, 16, 16, 16), child:
       stepnum=='1'? RichText(
        text: TextSpan(
          style: TextStyle(color: HexColor('#FFC40F'),
              fontWeight: FontWeight.w700,
              height:1.4,
              fontFamily: 'Barlow',
              fontSize: 16),
          children: <TextSpan>[
            TextSpan(text: "1:",),
            TextSpan(text: "\n•",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: HexColor('00CED3'))),
            TextSpan(text: " Stand up. Lay the paper on the floor.",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color: Colors.white)),
          ],
        ),
      ):stepnum=='2'?RichText(
         text: TextSpan(
           style: TextStyle(color: HexColor('#FFC40F'),
               fontWeight: FontWeight.w700,
               height:1.4,
               fontFamily: 'Barlow',
               fontSize: 16),
           children: <TextSpan>[
             TextSpan(text: "2:",),
             TextSpan(text: "\n•",
                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: HexColor('00CED3'))),
             TextSpan(text: " Place your entire",
                 style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color: Colors.white)),
             TextSpan(text: " $side foot",
                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,color: Colors.white)),
             TextSpan(text: " on the paper",
                 style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color: Colors.white)),
             TextSpan(text: "\n•",
                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: HexColor('00CED3'))),
             TextSpan(text: " When in position, press the button\n   to start recording, then rotate the\n   camera around your foot in a full\n   circle, ending with the heel.\n",
                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
             TextSpan(text: "\n•",
                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: HexColor('00CED3'))),
             TextSpan(text: " Press the camera button to stop\n   recording.",
                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
           ],
         ),
       ):RichText(
         text: TextSpan(
           style: TextStyle(color: HexColor('#FFC40F'),
               fontWeight: FontWeight.w700,
               height:1.4,
               fontFamily: 'Barlow',
               fontSize: 18),
           children: <TextSpan>[
             TextSpan(text: "TIPS",),
             TextSpan(text: "\n\n•",
                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: HexColor('00CED3'))),
             TextSpan(text: " Remain still.",
                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
             TextSpan(text: "\n\n•",
                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: HexColor('00CED3'))),
             TextSpan(text: " You can rotate the device in\n   whichever direction is most\n   comfortable for you.",
                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
             TextSpan(text: "\n\n•",
                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: HexColor('00CED3'))),
             TextSpan(text: " Make sure your entire foot remains\n   within the camera frame. ",
                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
             TextSpan(text: "\n\n•",
                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: HexColor('00CED3'))),
             TextSpan(text: " Try to keep a consistent distance\n   between the camera and foot as you\n   rotate. ",
                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
             TextSpan(text: "\n\n•",
                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: HexColor('00CED3'))),
             TextSpan(text: " To see the instructions and tutorial\n   video again, tap the help icon in the\n   upper right corner.",
                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
           ],
         ),
       )
     )),
      FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
              context,
              stepnum=='1'? SlideRoute(page: S4D('$side','2'),duration: 600,direction: 'Left'):stepnum=='2'?SlideRoute(page: S4D('$side','3'),duration: 600,direction: 'Left'):SlideRoute(page: getSmartPhoneOrTablet()=='android'?VideoWeb(side,false):VideoWebCamera(side,side,false,false),duration: 600,direction: 'Left'),
            );},
          child: Container(padding: EdgeInsets.fromLTRB(0, 0, 8, 16), alignment:Alignment.bottomRight,
              child: Text('NEXT',
                  style: new TextStyle(fontSize: 16.0, color: HexColor('#00CED3'))))
      ),

    ])
    );
  }
}

class V1E extends StatelessWidget {
  final String side;
  //final bool rescan;
  final bool new_vidset;
  V1E(this.side,this.new_vidset);


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
                    "Video: $side Foot", style: TextStyle(fontSize: 24,color: HexColor('#222222')))),
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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //VideoApp('assets/videos/T5A_T7B.mp4'),
            Center(child:Container(height: height/3, child: UrlPlayer(source:'https://firebasestorage.googleapis.com/v0/b/webapp-dev-662f0.appspot.com/o/videoscan_instructions_v2.mp4?alt=media&token=4025a450-2034-4e12-9179-a25308d71d8e'))),
            //Container(height: height/2.4,padding: EdgeInsets.all(16), child:VideoPlayerScreen(filepath:'gs://iambic-v1.appspot.com/Tutorial_videos/T5A_T7B.mp4')),
            Container(padding:EdgeInsets.all(16),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: HexColor('#222222'),
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        fontFamily: 'Barlow',
                        fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(text: "Scan your "),
                      TextSpan(text: '$side foot '.toLowerCase(),
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.5)),
                      TextSpan(text: "as instructed in the video.\n\nAs you rotate around your foot:"),
                    ],
                  ),
                )
            ),
            Container(padding:EdgeInsets.fromLTRB(32,0,32,8), child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u2022',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.55,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: HexColor('#222222'),
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            fontFamily: 'Barlow',
                            fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(text: "Hold your device consistently"),
                            TextSpan(text: ' 1 ft away from foot.',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.5)),
                        ],
                      ),
                    )
                  ),
                ),
            ])),
           Container(padding:EdgeInsets.fromLTRB(32,0,32,8), child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.55,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: HexColor('#222222'),
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                                fontFamily: 'Barlow',
                                fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(text: "Keep "),
                              TextSpan(text: ' entire foot ',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.5)),
                              TextSpan(text: "within camera frame."),
                            ],
                          ),
                        )
                    ),
                  ),
                ])),
          Container(padding:EdgeInsets.fromLTRB(32,0,32,8), child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.55,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: HexColor('#222222'),
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                                fontFamily: 'Barlow',
                                fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(text: "Keep foot"),
                              TextSpan(text: ' still ',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.5)),
                              TextSpan(text: "while recording."),
                            ],
                          ),
                        )
                    ),
                  ),
                ])),
            TextButton(
                onPressed: () {showModalBottomSheet<void>(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                        height: height-40,
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
                        child:V1M(side));}
                  ,isScrollControlled:true,);},
                child: Container(padding:EdgeInsets.fromLTRB(40,0,32,8), child:Text('Additional Tips', style: new TextStyle(decoration: TextDecoration.underline,
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
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  getSmartPhoneOrTablet()=='android'? VideoWeb(side,new_vidset):VideoWebCamera(side,side,new_vidset,new_vidset)));
                    /*Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (BuildContext context) => VideoWebo(side,false)),
                      //SlideRoute(page: VideoWebCamera(side,side,new_vidset,false),duration: 600,direction: 'Left'),
                      SlideRoute(page: VideoWeb(side,false),duration: 600,direction: 'Left'),
                    );*/
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

class S4 extends StatefulWidget {
  final String side;
  final bool new_vidset;
  S4(this.side,this.new_vidset);
  @override
  _S4State createState() => _S4State();
}
class _S4State extends State<S4> with SingleTickerProviderStateMixin {
  String _status1= 'current';
  String _status2='upcoming';
  String _status3='upcoming';
  String _status4='upcoming';
  String _status5='upcoming';
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
    if(widget.side=='Left' || widget.new_vidset) {
      _status1 = 'viewed';
      _status2 = 'viewed';
      _status3 = 'viewed';
      _status4 = 'viewed';
      _status5 = 'viewed';
    }
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(//Align(alignment: Alignment(-0.25, 0.5),
                child: Text(
                    "Video: "+widget.side+" Foot", style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    height:1.4,
                    fontFamily: 'Barlow',
                    fontSize: 24))),
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
                      context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                    );},
                  child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                      child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
            ],*/
          ),

          body:
          Column(children: [
            //VideoApp('assets/animation/S4.mp4'),
            //Container(height: height/2.4,padding: EdgeInsets.all(16), child:Image.asset('assets/lottiefiles/GettingReady.zip')),
            Container(height: height/2.6,padding: EdgeInsets.all(0), child: Image.asset('assets/images/RotateCamera.gif')),
          Expanded(child:RawScrollbar(isAlwaysShown: true,thumbColor: HexColor("#00CED3"),
          child:ListView(
          children:[
            Container(padding: EdgeInsets.fromLTRB(16, 8, 0, 8), alignment:Alignment.centerLeft,child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24),
                children: <TextSpan>[
                  TextSpan(text: "Checklist"),
                ],
              ),
            )),
            if(widget.side=='Right' && !rescan)
            Container(padding: EdgeInsets.fromLTRB(16, 0, 0, 8), alignment:Alignment.topLeft,child:
            RichText(
              text: TextSpan(
                style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w700,
                    height:1.4,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  //TextSpan(text: "1:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  TextSpan(text: "Tap the check mark "),
                  TextSpan(text: "after reading each step.",style: TextStyle(fontWeight: FontWeight.w400)),
                ],
              ),
            )),
            Container(padding: EdgeInsets.fromLTRB(16, 8, 0, 0),child:
            Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center ,children:[
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
              SizedBox(width:10),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: HexColor('#222222'),
                      fontWeight: FontWeight.w400,
                      height:1.4,
                      fontFamily: 'Barlow',
                      fontSize: 16),
                  children: <TextSpan>[
                    //TextSpan(text: "1:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    TextSpan(text: "Take a wide stance. Spread your feet\nabout 2 ft apart. Firmly place entire\n"),
                    TextSpan(text: widget.side.toLowerCase()+" foot",style: TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(text: " on paper.")
                  ],
                ),
              ),
            ])),
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
                          child:V1M(widget.side));}
                    ,isScrollControlled:true,);
                },
                child: Container(alignment: Alignment.centerLeft,padding: EdgeInsets.fromLTRB(52, 16, 16, 0),
                    child: Text('Having trouble with stance?', style: new TextStyle(decoration: TextDecoration.underline,
                        fontSize: 16.0, color: HexColor('#00CED3'))))
            ),
            if(_status1=='viewed')
            Container(padding: EdgeInsets.fromLTRB(16, 16, 0, 0),child:
            Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center ,children:[
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
                        : InkWell(
                      child: Icon(Icons.check, color: HexColor('#FFFFFF')),
                      onTap: () {
                        if(_status1=='viewed')
                        setState(() {
                          _status2 ='viewed';
                          _status3='current';
                          //_animationController.forward();
                        });
                      },
                    ),
                  )),
              SizedBox(width:10),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: HexColor('#222222'),
                      fontWeight: FontWeight.w400,
                      height:1.4,
                      fontFamily: 'Barlow',
                      fontSize: 16),
                  children: <TextSpan>[
                    //TextSpan(text: "1:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    TextSpan(text: "Hold device "),
                    TextSpan(text: "1 ft from back of heel.\n",style: TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(text: "Tap to start recording.")
                  ],
                ),
              ),
            ])),
            if(_status2=='viewed')
              Container(padding: EdgeInsets.fromLTRB(16, 16, 0, 0),child:
              Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center ,children:[
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
                          : InkWell(
                        child: Icon(Icons.check, color: HexColor('#FFFFFF')),
                        onTap: () {
                          if(_status1=='viewed' && _status2=='viewed')
                          setState(() {
                            _status3 ='viewed';
                            _status4='current';
                            //_animationController.forward();
                          });
                        },
                      ),
                    )),
                SizedBox(width:10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: HexColor('#222222'),
                        fontWeight: FontWeight.w400,
                        height:1.4,
                        fontFamily: 'Barlow',
                        fontSize: 16),
                    children: <TextSpan>[
                      //TextSpan(text: "1:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      TextSpan(text: "Rotate device around foot in a full\ncircle"),
                      TextSpan(text: " (whichever direction is most\ncomfortable), ending at heel.",style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ])),
            if(_status3=='viewed')
              Container(padding: EdgeInsets.fromLTRB(16, 16, 0, 0), child:
              Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,children:[
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
                          if(_status1=='viewed' && _status2=='viewed'&&_status3=='viewed')
                            setState(() {
                              _status4 ='viewed';
                              _status5='current';
                            });
                        },
                      ),
                    )),
                SizedBox(width:10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: HexColor('#222222'),
                        fontWeight: FontWeight.w700,
                        height:1.4,
                        fontFamily: 'Barlow',
                        fontSize: 16),
                    children: <TextSpan>[
                      //TextSpan(text: "\n2:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      TextSpan(text: "Keep entire foot still within camera\nframe."),
                      TextSpan(text: " Smoothly rotate device at a\n",style: TextStyle(fontWeight: FontWeight.w400)),
                      TextSpan(text: "constant speed."),
                    ],
                  ),
                ),
              ])),
            if(_status4=='viewed')
              Container(padding: EdgeInsets.fromLTRB(16, 16, 0, 0),child:
              Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,children:[
                ClipOval(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: setColor(_status5),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(width: 2,color: setBorderColor(_status5),style: BorderStyle.none),
                      ),
                      child: _status5=='viewed' ? Icon(Icons.check, color: HexColor('#00CED3'))
                          : InkWell(child:
                      Icon(Icons.check, color: HexColor('#FFFFFF')),
                        onTap: () {
                          if(_status1=='viewed' && _status2=='viewed'&&_status3=='viewed'&&_status4=='viewed')
                            setState(() {
                              _status5 ='viewed';
                              //_status5='current';
                            });
                        },
                      ),
                    )),
                SizedBox(width:10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: HexColor('#222222'),
                        fontWeight: FontWeight.w400,
                        height:1.4,
                        fontFamily: 'Barlow',
                        fontSize: 16),
                    children: <TextSpan>[
                      //TextSpan(text: "\n2:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      TextSpan(text: "Tap to stop recording."),
                    ],
                  ),
                ),
              ])),
            //SizedBox(height:25),
                  ]))),
            if(_status1=='viewed' && _status2=='viewed' && _status3=='viewed' && _status4=='viewed' && _status5=='viewed')
              Container(alignment: FractionalOffset.bottomRight, child:
              FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => T5A('right')),
                    //SlideRoute(page: S4H(widget.side),duration: 600,direction: 'Left'),
                    SlideRoute(page: getSmartPhoneOrTablet()=='android'?VideoWeb(widget.side,widget.new_vidset):VideoWebCamera(widget.side,widget.side,widget.new_vidset,widget.new_vidset),duration: 600,direction: 'Left'),
                  );
                },
                child:
                Padding(padding:EdgeInsets.all(16),child:Text('GOT IT', style: new TextStyle(letterSpacing: 1.5,
                    fontSize: 17.0, color: HexColor('#00CED3'),fontWeight: FontWeight.w700))),
              )),
          ]

          )),

    );
    //);
  }
}

class V1M extends StatelessWidget {
  final String side;
  //final bool rescan;
  V1M(this.side);
  @override
  Widget build(BuildContext context) {
    String other_foot=side=='Left'?'right':'left';
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
      /*Container(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          width: 360,
          height: 250,
          child: Image.asset('assets/images/T5AM.png', fit: BoxFit.fill)),*/
      Container(width: double.infinity, padding: EdgeInsets.fromLTRB(32, 16, 16, 0), child:
      Text("Take a wide stance. When spreading your feet apart, stand so that your" + " $side".toLowerCase() + " foot is about 2 ft away from your $other_foot.\n\nKeep your weight on your" + " $side".toLowerCase() + "foot while recording.\n\nIf needed, you can hold onto a chair with your free hand for support.\n\nRotate your device around your foot at a constant speed in whichever direction is most comfortable.\n\nMaintain a steady distance with your whole foot within camera frame.\n\nKeep foot still!",
          style: TextStyle(color: HexColor('#222222'),
              fontWeight: FontWeight.w400,
              height: 1.5,
              fontFamily: 'Barlow',
              fontSize: 16),
        ),
      ),

    ]

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

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.filepath,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Container(height: height / 2.5,
      child: _controller.value.initialized
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      )
          : Container(color: Colors.white,),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    debugPrint('CmVideoPlayer - dispose()');
  }
}

class S4H extends StatelessWidget {
  final String side;
  S4H(this.side);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Center(//Align(alignment: Alignment(-0.25, 0),
            child: Text(
                "Videos: $side Foot", style: TextStyle(fontWeight: FontWeight.w600,
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
                  context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
                );},
              child: Container(padding: EdgeInsets.fromLTRB(0,8,16,0),
                  child: Image.asset('assets/images/icon_logout.png',width: 32, height: 32))),
        ],*/
      ),

      body:
      Column(children:[
        Container(alignment:Alignment.centerLeft,padding:EdgeInsets.fromLTRB(16,16,16,0),child:Text("Tips",style: TextStyle(color: HexColor('#00CED3'),
            fontWeight: FontWeight.w600,
            height:1.4,
            fontFamily: 'Barlow',
            fontSize: 24))),
        Container(padding:EdgeInsets.fromLTRB(32,16,24,0),child:RichText(
          text: TextSpan(
            style: TextStyle(color: HexColor('#00CED3'),
                fontWeight: FontWeight.w400,
                height:1.4,
                fontFamily: 'Barlow',
                fontSize: 18),
            children: <TextSpan>[
              TextSpan(text: "Remain still.\n\n",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color: HexColor('222222'))),
              TextSpan(text: "You can rotate the device in whichever direction is most comfortable for you.\n\n",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color: HexColor('222222'))),
              TextSpan(text: "Make sure your entire foot remains within the camera frame.\n\n",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color: HexColor('222222'))),
              TextSpan(text: "Try to keep a consistent distance between the camera and foot as you rotate.\n\n",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color: HexColor('222222'))),
              TextSpan(text: "To see the instructions and tutorial video again, tap the help icon in the upper right corner.\n\n",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color: HexColor('222222'))),
            ],
          ),
        )),
        Expanded(child:Align(alignment: FractionalOffset.bottomRight, child: FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
            onPressed: (){
              Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => S4D(side,'1')),
                SlideRoute(page: getSmartPhoneOrTablet()=='android'?VideoWeb(side,false):VideoWebCamera(side,side,false,false),duration: 600,direction: 'Left'),
              );},
            child: Text('GOT IT', style: new TextStyle(fontSize: 17.0, color: HexColor('#00CED3')))))
        )

      ]

      ),
    );
    //);
  }
}
