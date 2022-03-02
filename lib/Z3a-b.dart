import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:iambic_research/Tutorial.dart';
//import 'package:iambic_research/landing_page.dart';
import '/slide_transition.dart';
//import 'package:iambic_research/bubble_level.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import '/google_signin.dart';
import '/scan.dart';
import '/faq.dart';
import 'T4.dart';
import 'foot_survey/S.dart';
import '/foot_survey/video_capture.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:device_info/device_info.dart';
import '/landing_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

//void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  //runApp(EmailLog());
//}
String userEmail;

class EmailLog extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body: RootPage(auth: Auth()),
    );
  }
}

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userdata');
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Future<void> updateUserData(String name, String lastname) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return await userCollection.doc(uid).set({
      'name': name,
      'lastname': lastname,
      'phone_model': androidInfo.model,
      'Android_version':androidInfo.version.release,
    });
  }

}

abstract class BaseAuth {

  Future<String> currentUser();
  //Future<String> signIn(String email, String password);
  Future<bool> signIn(String email, String password);
  //Future<String> createUser(String email, String password, String name, String last_name);
  Future<bool> createUser(String email, String password, String name, String last_name);
  
  Future<void> signOut();
}

class Auth implements BaseAuth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userdata');
  //Future<String> signIn(String email, String password) async {
    Future<bool> signIn(String email, String password) async {
    //User user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;

    //UserCredential user2 = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    //final uid= _firebaseAuth.currentUser.uid;
    //bool newuser=user2.additionalUserInfo.isNewUser;
    //print(user2.additionalUserInfo.isNewUser);
    //return uid;
      //return newuser;
    //return user.uid;
    //return lst;
  }



  //Future<String> createUser(String email, String password, String name, String last_name) async {
  Future<bool> createUser(String email, String password, String name, String last_name) async {
    //User user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    //UserCredential user2 = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    //final uid= _firebaseAuth.currentUser.uid;
    //bool newuser=user2.additionalUserInfo.isNewUser;
    //print(user2.additionalUserInfo.isNewUser);
    //await DatabaseService(uid:uid).updateUserData(name, last_name);
    //return uid;
    //return newuser;
    //await DatabaseService(uid:user.uid).updateUserData(name, last_name);
    //return user.uid;
  }

  Future<String> currentUser() async {
    User user = _firebaseAuth.currentUser;
    //FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user != null ? user.uid : null;

  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }


}

Widget policyTerms(){
  return RichText(
    text: TextSpan(
      style: TextStyle(color: Colors.black,
          fontWeight: FontWeight.w400,
          height: 1.2,
          fontFamily: 'Barlow',
          fontSize: 12),
      children: <TextSpan>[
        TextSpan(text: '______'),
        TextSpan(text: '\n\nBy logging in or creating an account, you agree\nto the'),
        TextSpan(text: ' privacy policy ', style: TextStyle(fontWeight:FontWeight.w600),recognizer: new TapGestureRecognizer()
          ..onTap = () { launch('https://www.iambic.co/policies/privacypolicy');}),
        TextSpan(text: 'and'),
        TextSpan(text: ' terms of service', style: TextStyle(fontWeight:FontWeight.w600),recognizer: new TapGestureRecognizer()
          ..onTap = () { launch('https://www.iambic.co/policies/termsofuse');}),
      ],
    ),
  );

}

class FirstTimeHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        body: new Center(
          child: S1A0()//CameraScreen(flag:true,view: 'top')
        )
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;


  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
        Navigator.push(
          context, SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
        );
      } catch (e) {
        print(e);
      }
    }

    void signOutGoogle() async{
      //await googleSignIn.signOut();
      Navigator.push(
        context,
        //MaterialPageRoute(builder: (context) => MainLogin()),
        SlideRoute(page: Landing_page(),duration: 600,direction: 'Left'),
      );
      print("User Sign Out");
    }

    return new Scaffold(
        appBar: new AppBar(automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.subject),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          backgroundColor: HexColor('#A5E0E5'),
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          //actions: <Widget>[
            //new FlatButton(
               // onPressed: _signOut,
                //child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.teal))
            //)
          //],
        ),
        body: //new Center(
            //child: TutorialList2(arg1: 'viewed',arg2:'current')//CameraScreen(flag:true,view: 'top')
        //),
        Stack(children:[
          Container(
            //padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              width: width,
              height:height,
              //color:HexColor('#A5E0E5') ,
              child:
              Image.asset('assets/images/bg_scan_v1.png', fit: BoxFit.cover)),
         Column(children:[
          Container(width:328*width/360,height:264*height/640, decoration: new BoxDecoration(
             color: HexColor('00CED3'),
             borderRadius: new BorderRadius.all(Radius.circular(10.0))),child:
              Stack(children:[
                Container(width:328*width/360,height:104*height/640,padding: EdgeInsets.fromLTRB(8,16,0,0),
                  decoration: BoxDecoration(
                      color:HexColor('#E5E5E5').withOpacity(0.6),
                      borderRadius: new BorderRadius.only(
                          topLeft:  const  Radius.circular(10.0),
                          topRight: const  Radius.circular(10.0))
                  ),
                 child:Column(crossAxisAlignment: CrossAxisAlignment.start,children:[
                       Row(children:[
                         Image.asset('assets/images/icon_home_1fitprofile.png'),
                         SizedBox(width:20),
                         Text('Fit Profile',style:TextStyle(
                             color: HexColor('#222222'),
                             //Colors.grey[800],
                             fontWeight: FontWeight.w600,
                             //fontStyle: FontStyle.italic,
                             fontFamily: 'Barlow',
                             fontSize: 32))
                       ]),
                       SizedBox(height:30),
                       Container(padding: EdgeInsets.only(left:8),child:Text("YOUR CURRENT SIZE RANGE:",style:TextStyle(
                           color: HexColor('#222222'),
                           //Colors.grey[800],
                           fontWeight: FontWeight.w500,
                           //fontStyle: FontStyle.italic,
                           fontFamily: 'Barlow',
                           fontSize: 16))),
                  ]),
                ),
                Positioned(top:104*height/640,child:Container(padding: EdgeInsets.only(top: 50),
                    width:328*width/360, height:113*height/640,color: Colors.white,
                  child:Text('Looks like you haven’t scanned\n your feet yet. Let’s get you started.',textAlign: TextAlign.center,
                      style:TextStyle(
                          color: HexColor('#222222'),
                          height: 0.7,
                          fontWeight: FontWeight.w400,
                          //fontStyle: FontStyle.italic,
                          fontFamily: 'Barlow',
                          fontSize: 18))

                )),
                Positioned(top:230*height/640,left:115*width/360,child:InkWell(
                  // When the user taps the button, show a snackbar.
                  onTap: () {
                    /*Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => VideoPage()),//bubble_level(view:'Top',side:'Right')),
                      SlideRoute(page: VideoPage(),duration: 600,direction: 'Left'),
                    );*/
                  },child:
                 Row(children:[
                   Text('START SCAN',textAlign: TextAlign.center,
                        style:TextStyle(
                            color: HexColor('#222222'),
                            //height: 0.7,
                            fontWeight: FontWeight.w700,
                            //fontStyle: FontStyle.italic,
                            fontFamily: 'Barlow',
                            fontSize: 16)),
                    SizedBox(width:112),
                    Icon(Icons.arrow_forward_ios,color: Colors.white)
                  ]
                 ),
                ))
              ])
          ),
           SizedBox(height:10),
          Divider(color: Colors.white),
           InkWell(
             // When the user taps the button, show a snackbar.
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => Scan()),
                 );
               },
               child:Container(padding: EdgeInsets.fromLTRB(24,16,0,16),child:Row(children:[
                 Image.asset('assets/images/icon_home_2scan_v1.png'),
                 SizedBox(width:20),
                 Text('Scan',style:TextStyle(
                 color: HexColor('#222222'),
                     fontWeight: FontWeight.w600,
                     fontFamily: 'Barlow',
                     fontSize: 32)),
                 SizedBox(width:210),
                 Icon(Icons.arrow_forward_ios,color: Colors.white,)

          ]))),
          Divider(color: Colors.white),
           InkWell(
             // When the user taps the button, show a snackbar.
               onTap: () {},
               child:Container(padding: EdgeInsets.fromLTRB(24,16,0,16),child:Row(children:[
                 Image.asset('assets/images/icon_home_3shop_v1.png'),
                 SizedBox(width:20),
                 Text('Shop',style:TextStyle(
                     color: HexColor('#222222'),
                     fontWeight: FontWeight.w600,
                     fontFamily: 'Barlow',
                     fontSize: 32)),
                 SizedBox(width:100),
                 Text('COMING SOON',style:TextStyle(
                     color: HexColor('#FFFFFF'),
                     fontWeight: FontWeight.w700,
                     fontFamily: 'Barlow',
                     fontSize: 14)),
                 SizedBox(width:12),
                 Icon(Icons.arrow_forward_ios,color: Colors.white,)
               ]))),
          Divider(color: Colors.white),
           InkWell(
             // When the user taps the button, show a snackbar.
               onTap: () {Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => faq()),
               );},
               child:Container(padding: EdgeInsets.fromLTRB(35,16,0,16),child:Row(children:[
                 Image.asset('assets/images/icon_home_4faq_v1.png'),
                 SizedBox(width:20),
                 Text('FAQ',style:TextStyle(
                     color: HexColor('#222222'),
                     //Colors.grey[800],
                     fontWeight: FontWeight.w600,
                     //fontStyle: FontStyle.italic,
                     fontFamily: 'Barlow',
                     fontSize: 32)),
                 SizedBox(width:225),
                 Icon(Icons.arrow_forward_ios,color: Colors.white,)
               ]))),
          Divider(color: Colors.white),
           ]

          ),
         ],
        ),
      drawer: Drawer(
       child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(color: HexColor('##A5E0E5'),child:DrawerHeader(
              child: Align(alignment:Alignment.topLeft ,child:IconButton(
                icon: Icon(Icons.close),iconSize: 35,color: HexColor('#222222'),
                onPressed: () {Navigator.pop(context);},
              ),
            ))),
            ListTile(
              title: Text('Settings',style:TextStyle(
                 color: HexColor('#222222'),
                 //Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 32)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('About',style:TextStyle(
                  color: HexColor('#222222'),
                  //Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 32)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Contact',style:TextStyle(
                  color: HexColor('#222222'),
                  //Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 32)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Log Out',style:TextStyle(
                  color: HexColor('#222222'),
                  //Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 32)),
              onTap: () { _signOut();
                          signOutGoogle();

                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: SizedBox(),
            ),
            ListTile(
              title: Text('Terms of Use',style:TextStyle(
                  color: HexColor('#222222'),
                  //Colors.grey[800],
                  fontWeight: FontWeight.w400,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Privacy Policy',style:TextStyle(
                  color: HexColor('#222222'),
                  //Colors.grey[800],
                  fontWeight: FontWeight.w400,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: SizedBox(),
            ),
            ListTile(
              title: Text('© 2020 Iambic Inc.',style:TextStyle(
                  color: HexColor('#222222'),
                  //Colors.grey[800],
                  fontWeight: FontWeight.w400,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 12)),

            ),
    ],
        ),
      ),
    );
  }
}


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.onSignIn, this.ifNewUser}) : super(key: key);

  String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;
  final Function(bool) ifNewUser;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType {
  z3a,
  register,
  login,
  forgotpass
}

class _LoginPageState extends State<LoginPage> {
  //static final formKey = new GlobalKey<FormState>();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
      return <String, dynamic>{
        'appCodeName': data.appCodeName,
        'appName': data.appName,
        'appVersion': data.appVersion,
        'deviceMemory': data.deviceMemory,
        'language': data.language,
        'languages': data.languages,
        'platform': data.platform,
        'product': data.product,
        'productSub': data.productSub,
        'userAgent': data.userAgent,
        'vendor': data.vendor,
        'vendorSub': data.vendorSub,
        'hardwareConcurrency': data.hardwareConcurrency,
        'maxTouchPoints': data.maxTouchPoints,
      };
    }

    deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);

        if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });

  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
    //PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', errorText: 'password does not meet all the requirements listed')
  ]);
  String _email;
  String _password;
  String name;
  String last_name;
  bool _obscureText = false;
  bool newsletter,iambisphere;
  //FormType _formType = FormType.login;
  FormType _formType = FormType.register;
  String _authHint = '';
  bool isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Map<String, bool> values = {
    'Subscribe to Iambic’s newsletter': false,
    //'Gender non-conforming': false,
    //'Gender variant': false,
    // 'Intersex': false,
    //'Sign me up for Iambisphere': false,
  };

  var tmpArray = [];
  int count=0;

  getCheckboxItems(){

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
    tmpArray.clear();
  }



  bool validateStructure(String value){
    //pattern for password with at least one capital letter and number and 6 characters
    //String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    //email format structure
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  showAlertDialog(String errormsg) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {Navigator.of(context, rootNavigator: true).pop('dialog');},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(""),
      content: Text(errormsg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        //String userId = _formType == FormType.login
        bool newuser = _formType == FormType.login
            ? await widget.auth.signIn(_email, _password)
            : await widget.auth.createUser(_email, _password,name, last_name);
        newuser? widget.ifNewUser(true):widget.ifNewUser(false);
        setState(() {
          //_authHint = 'Signed In\n\nUser id: $userId';
          newuser ? _authHint='New User': _authHint='Old User';
          isLoading = false;
        });
        widget.onSignIn();

      }
      catch (e) {
        setState(() {
          _authHint = 'Sign In Error\n\n${e.toString()}';
          isLoading = false;
        });
        print(e);
        showAlertDialog(_authHint.replaceAll("[firebase_auth/", "["));
      }
    } else {
      setState(() {
        _authHint = '';
        isLoading = false;
      });
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _authHint = '';
    });
  }

  void moveToName() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.z3a;
      _authHint = '';
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _authHint = '';
    });
  }

  void moveToForgotpass() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.forgotpass;
      _authHint = '';
    });
  }


  List<Widget> usernameAndPassword() {
    switch (_formType) {
      case FormType.z3a:
        return [
          Column(children:[
            SizedBox(height:20),
            padded(
                child: new TextFormField(
                  key: new Key('name'),
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      //labelText: "Email",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48.0),
                        borderSide: BorderSide(
                          color: HexColor('#A5E0E5'),
                          width: 2.0,
                        ),
                      ),
                      hintText: 'First name'),
                  autocorrect: false,
                  validator: (val) =>
                  val.isEmpty
                      ? 'Name can\'t be empty.'
                      : null,
                  onSaved: (val) => name = val,
                )),
            padded(child: new TextFormField(
              key: new Key('lastname'),
              decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 24.0),
                  //labelText: "Lastname",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.0),
                    borderSide: BorderSide(
                      color: HexColor('#A5E0E5'),
                      width: 2.0,
                    ),
                  ), hintText: 'Last name'),
              obscureText: false,
              autocorrect: false,
              validator: (val) =>
              val.isEmpty
                  ? 'Last name can\'t be empty.'
                  : null,
              onSaved: (val) => last_name = val,
            )),
            Container(padding:EdgeInsets.fromLTRB(16,16,0,0),child:Row(mainAxisAlignment: MainAxisAlignment.end,children:[
              GestureDetector(
                key: new Key('register 2nd page'),
                child: new Text("NEXT",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 16)),
                onTap: (){ validateAndSave();
                               moveToRegister();}

            ),
              Icon(Icons.arrow_forward),
           ])),

          ]),
        ];
      case FormType.register:
        return [
          Column(children: [
            Container(padding: const EdgeInsets.all(16.0), width:double.infinity, child:
             Text('Your email allows us to contact you if you win the Bespoke Sneaker Sweepstakes, qualify for future Iambisphere initiatives, or if there are any issues with your submission.',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: 0,
                  fontFamily: 'Barlow',
                  fontSize: 16),
            )),
            Container(padding: const EdgeInsets.fromLTRB(16,0,16,16), width:double.infinity, child:
            Text('We will not share your email with any third parties.',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16),
            )),
            padded(
                child: new TextFormField(
                  key: new Key('email'),
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      //labelText: "Email",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48.0),
                        borderSide: BorderSide(
                          color: HexColor('#A5E0E5'),
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Email'),
                  autocorrect: false,
                  validator: (val) =>
                  val.isEmpty
                      ? 'Email can\'t be empty.'
                      : validateStructure(val) ? null:'Email format is incorrect.',
                  onSaved: (val) => _email = val,
                )),
            /*padded(child: new TextFormField(

              key: new Key('password'),
              decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 24.0),
                  //labelText: "Password",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.0),
                    borderSide: BorderSide(
                      color: HexColor('#A5E0E5'),
                      width: 2.0,
                    ),
                  ), hintText: 'Password'),
              obscureText: !_obscureText,
              autocorrect: false,
              onChanged: (val) => _password = val,
              //validator: passwordValidator,
              //onSaved: (val) => _password = val,
            )),
            padded(child: Row(children:[
              Theme(data: ThemeData(unselectedWidgetColor: HexColor('00CED3')),child: Checkbox(
                value: _obscureText,
                activeColor: HexColor('#00CED3'),
                onChanged: (value) {setState(() {
                  _obscureText = !_obscureText;
                });
                },
              )),
              Text('Show Password?')
            ])
            ),*/
            //padded(child: new TextFormField(
            //  key: new Key('confirm password'),
            //  decoration: new InputDecoration(
            //      contentPadding: const EdgeInsets.only(left: 24.0),
                  //labelText: "Confirm password",
            //      fillColor: Colors.white,
            //      focusedBorder: OutlineInputBorder(
            //        borderRadius: BorderRadius.circular(48.0),
            //        borderSide: BorderSide(
            //          color: Colors.blue,
            //        ),
            //      ),
            //      enabledBorder: OutlineInputBorder(
            //        borderRadius: BorderRadius.circular(48.0),
            //        borderSide: BorderSide(
            //          color: HexColor('#A5E0E5'),
            //          width: 2.0,
             //       ),
               //   ), hintText: 'Confirm password'),
             // obscureText: true,
             // autocorrect: false,
              //onChanged: (val) => _password = val,
             // validator: (val) => MatchValidator(errorText: 'passwords do not match').validateMatch(val, _password),
              //(val) =>
              //val.isEmpty
                  //? 'Password can\'t be empty.'
                  //: null,
              //onSaved: (val) => _password = val,
           // )),
            GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child:
            Column(mainAxisSize: MainAxisSize.min, children: values.keys.map((String key) {
                return SizedBox(
                    height: 40.0,child: CheckboxListTile(
                  title: Text(key),
                  value: values[key],
                  activeColor: HexColor('#00CED3'),
                  checkColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      values[key] = value;
                    });
                  },
                ));
              }).toList(),
            )),
            SizedBox(height:10),
            !isLoading ? padded(child:PrimaryButton(
                key: new Key('login'),
                text: "LET'S BEGIN",
                height: 48.0,
                onPressed: () async{
                              if(validateAndSave()) {
                                setState(() => isLoading = true);
                                await FirebaseAuth.instance.signInAnonymously();
                                //UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
                                var firebaseUser = FirebaseAuth.instance.currentUser;
                                //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
                                final firestoreInstance = FirebaseFirestore.instance;
                                userEmail=_email;
                                final Map<String, dynamic> tempMap =values;
                                tempMap.removeWhere((String key, dynamic value)=> value==false);
                                firestoreInstance.collection("userdata").doc(firebaseUser.uid)
                                    .set({"newsletter": tempMap,"email":_email,"Device_data":_deviceData}).then((_) {
                                  print("success!");
                                });
                                //FirebaseAuth.instance.signInAnonymously();
                                Navigator.push(
                                  context,
                                  SlideRoute(page: S1A0(),
                                      duration: 600,
                                      direction: 'Left'),
                                );
                               }
                              },
               )): Padding(padding:EdgeInsets.only(top:16),child:CircularProgressIndicator()),

            /*Container(alignment:Alignment.centerLeft, padding: const EdgeInsets.only(left:16.0,top:32), child:RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w400,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: '* ',style: TextStyle(color: Colors.red)),
                  TextSpan(text: 'Password should contain:',style: TextStyle(fontWeight:FontWeight.w600)),
                  TextSpan(text: '\n'+ String.fromCharCode(0x2022)+' At least 8 characters'+ '\n' + String.fromCharCode(0x2022)
                      + ' Both uppercase and lowercase letters'+ '\n' + String.fromCharCode(0x2022)+ ' At least one number'
                      + '\n' + String.fromCharCode(0x2022) + ' At least one special character')
                ],
              ),
            )),*/
          ]),
        ];
      case FormType.login:
        return [
          Column(children: [
            Container(alignment:Alignment.centerLeft, padding: const EdgeInsets.fromLTRB(16.0,32.0,16.0,16.0), child:
             Row(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.start,children:<Widget>[
              Text('Don’t have an account?',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 16),
              ),
              GestureDetector(
                  key: new Key('login page'),
                  child: new Text(" Register here.",style: TextStyle(
                      color: HexColor('#00CED3'),
                      fontWeight: FontWeight.w600,
                      //fontStyle: FontStyle.italic,
                      fontFamily: 'Barlow',
                      fontSize: 16)),
                  onTap:  (){moveToName();}
              ),
            ]
            )),
            padded(
                child: new TextFormField(
                  key: new Key('email'),
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      //labelText: "Email",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48.0),
                        borderSide: BorderSide(
                          color: HexColor('#00CED3'),
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Email'),
                  autocorrect: false,
                  validator: (val) =>
                  val.isEmpty
                      ? 'Email can\'t be empty.'
                      : null,
                  onSaved: (val) => _email = val,
                )),
            padded(child: new TextFormField(

              key: new Key('password'),
              decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 24.0),
                  //labelText: "Password",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.0),
                    borderSide: BorderSide(
                      color: HexColor('#00CED3'),
                      width: 2.0,
                    ),
                  ), hintText: 'Password'),
              obscureText: !_obscureText,
              autocorrect: false,
              onChanged: (val) => _password = val,
              validator: passwordValidator,
              //onSaved: (val) => _password = val,
            )),

            padded(child: Row(children:[
              Theme(data: ThemeData(unselectedWidgetColor: HexColor('00CED3')),child: Checkbox(
                value: _obscureText,
                activeColor: HexColor('#00CED3'),
                onChanged: (value) {setState(() {
                  _obscureText = !_obscureText;
                });
                },
              )),
              Text('Show Password?')
            ])
            ),


            !isLoading ? padded(child:PrimaryButton(
              key: new Key('login'),
              text: 'SUBMIT',
              height: 48.0,
              onPressed: (){
                setState(() => isLoading = true);
                validateAndSubmit();
              },
            )): CircularProgressIndicator(),

            Container(alignment: Alignment.topLeft, width:double.infinity,height:50, child:
             FlatButton(
                key: new Key('forgot password'),
                child: new Text("Forgot your password?",style: TextStyle(
                    color: HexColor('#00CED3'),
                    fontWeight: FontWeight.w700,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 16)),
                onPressed: (){//validateAndSave();
                              setState(() => _formType=FormType.forgotpass);
                              //resetPassword(_email);
                              }

            ),),
          ])
        ];
      case FormType.forgotpass:
        return [
           Column(children: [
            Container(padding: const EdgeInsets.all(16.0), width:double.infinity,height:80, child:
            Text('That’s okay, we’ve got you covered. Enter your\nemail to receive a link to reset your password.',
            style: TextStyle(
                color: HexColor('#222222'),
                fontWeight: FontWeight.w400,
                height: 1.5,
                fontFamily: 'Barlow',
                fontSize: 16),
          )),
             padded(child: new TextFormField(
                key: new Key('email'),
                decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 24.0),
                    //labelText: "Email",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.0),
                      borderSide: BorderSide(
                        color: HexColor('#A5E0E5'),
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Email'),
                autocorrect: false,
                validator: (val) =>
                val.isEmpty
                    ? 'Email can\'t be empty.'
                    : null,
                onSaved: (val) => _email = val,
              )),

            !isLoading ? padded(child:PrimaryButton(
            key: new Key('login'),
            text: 'RESET PASSWORD',
            height: 48.0,
            onPressed: (){
              validateAndSave();
              resetPassword(_email);
              //showAlertDialog("Reset password link has been sent to your email!");
              Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => return2login()),
                SlideRoute(page: return2login(),duration: 600,direction: 'Left'),
              );
            },
          )): CircularProgressIndicator(),
             Container(alignment: Alignment.topLeft, width:double.infinity,height:50, child:
              FlatButton(
                 key: new Key('return to login'),
                 child: new Text("Return to Login?",style: TextStyle(
                     color: HexColor('#00CED3'),
                     fontWeight: FontWeight.w600,
                     //fontStyle: FontStyle.italic,
                     fontFamily: 'Barlow',
                     fontSize: 16)),
                 onPressed: (){
                   setState(() => _formType=FormType.login);

                 }

             ),),

        ]),
       ];
    }

  }


  Widget hintText() {
    return new Container(
      //height: 80.0,
        padding: const EdgeInsets.all(32.0),
        child: new Text(
            _authHint,
            key: new Key('hint'),
            style: new TextStyle(fontSize: 18.0, color: Colors.grey),
            textAlign: TextAlign.center)
    );
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
        appBar: PreferredSize(
         preferredSize: Size.fromHeight(50.0),child: AppBar(automaticallyImplyLeading: false,
            /*leading: IconButton(
            icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
            //onPressed:() => Navigator.pop(context, false),
            onPressed: () {_formType == FormType.register? setState(() {
                            _formType = FormType.z3a;
            }):Navigator.push(
              context,
              //MaterialPageRoute(builder: (context) => MainLogin()),
              SlideRoute(page: MainLogin(),duration: 600,direction: 'Left'),
            );
          }),*/
          elevation: 0.0,
          backgroundColor: HexColor('FFC40F'),
          title:_formType == FormType.login?Text('Login with Email',style: TextStyle(
          color: HexColor('#FFFFFF'),
            fontWeight: FontWeight.w600,
            fontFamily: 'Barlow',
            fontSize: 30)):_formType == FormType.forgotpass?Text("Forgot Password?",style: TextStyle(color: HexColor('#FFFFFF'),
              fontWeight: FontWeight.w600,
              fontFamily: 'Barlow',
              fontSize: 30)):Center(//Align(alignment: Alignment(-0.25, 0),
                  child: Text("Iambic Research",style: TextStyle(color: HexColor('#222222'),
              fontWeight: FontWeight.w600,
              fontFamily: 'Barlow',
              fontSize: 24)),
        ))),
        backgroundColor: Colors.white,
        body: Column(children: [
              //new Card(elevation: 0,

              new Container(
                  padding: const EdgeInsets.only(left:16.0,right:16),
                  child: new Form(
                      key: formKey,
                      child: new Column(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: usernameAndPassword()// + submitWidgets(),
                      )
                  )
              ),
              // ])
              //),
              //hintText()
              Expanded(child:Container(padding: EdgeInsets.all(16),width:width,height:_formType == FormType.z3a ? 250:_formType == FormType.register?70:200 ,alignment: Alignment.bottomLeft,
               child:policyTerms())),
            ]
        )
      //))
    );
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
      child: child,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  PrimaryButton({this.key, this.text, this.height, this.onPressed}) : super(key: key);
  final Key key;
  final String text;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: BoxConstraints.expand(height: height),
      child: new FlatButton(
          child: new Text(text, style: TextStyle(
              color: HexColor('#FFFFFF'),
              fontWeight: FontWeight.w700,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Barlow',
              fontSize: 16),),
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(height / 2))),
          color: Colors.black,
          textColor: Colors.black87,
          onPressed: onPressed),
    );
  }
}

class RootPage extends StatefulWidget {
  RootPage({Key key, this.auth}) : super(key: key);
  final BaseAuth auth;



  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.notSignedIn;
  //_LoginPageState currentLogin;
  bool newUser=false;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
      //final flag=currentLogin.validateAndSave();
    });
  }

  void _updateAuthStatus(AuthStatus status) {

    setState(() {
      authStatus = status;
    });
  }


  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          title: '',
          auth: widget.auth,
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
          ifNewUser: (bool val) {
            setState(() => newUser = val);
            print(newUser);
          },
        );
      case AuthStatus.signedIn:

        return newUser?
        S1A0():S1A0();
        //HomePage(
        //    auth: widget.auth,
        //    onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn)
        //);
    }
  }
}

class MainLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              width: width-32,//378.0,
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
                    //MaterialPageRoute(builder: (context) => EmailLog()),
                    SlideRoute(page: EmailLog(),duration: 300,direction: 'Left'),
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
              width: width-32,
              decoration: new BoxDecoration(

                  color: Colors.white,
                  borderRadius: new BorderRadius.all(const  Radius.circular(25.0))

              ),
              child:FlatButton(
                onPressed: () async {
                  /*signInWithGoogle().then((result) {
                    if (result != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return EmailLog();
                        },
                      ),
                    );
                    }
                  });*/
                },
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

          Positioned.fill(child:Container(padding: EdgeInsets.all(16),
              alignment: FractionalOffset.bottomLeft, child: policyTerms())),
        ]
        ),

      ),

    );

  }
}

class return2login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),child: AppBar(automaticallyImplyLeading: false,
          /*leading: IconButton(
            icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
            //onPressed:() => Navigator.pop(context, false),
            onPressed:() {
              Navigator.pop(context);
            }
            //onPressed: () {
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => MainLogin()),);
            //}
            ),*/

          elevation: 0.0,
          backgroundColor: HexColor('00CED3'),
          title:Text("Forgot Password?",style: TextStyle(color: HexColor('#FFFFFF'),
              fontWeight: FontWeight.w600,
              fontFamily: 'Barlow',
              fontSize: 30)),
        )),
        backgroundColor: Colors.white,
        body: Container(padding:EdgeInsets.all(16.0) ,child:Column(children: [
          Text("Got it! If an account exists at this address, an\nemail will be sent with a recovery link and\nfurther instructions. ",style: TextStyle(color: HexColor('222222'),
              fontWeight: FontWeight.w400,
              fontFamily: 'Barlow',
              fontSize: 16)),
          SizedBox(height:50),
          PrimaryButton(
            key: new Key('return2login'),
            text: 'RETURN TO LOGIN',
            height: 48.0,
            onPressed: (){
              Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => MainLogin()),
                SlideRoute(page: MainLogin(),duration: 600,direction: 'Left'),
              );
            },
          ),
          Expanded(child:Container(padding: EdgeInsets.all(16),width:width,height:200 ,alignment: Alignment.bottomLeft,
              child:policyTerms())),
        ]
        ))
      //))
    );
  }

}