import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Login',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}

abstract class BaseAuth {

  Future<String> currentUser();
  Future<String> signIn(String email, String password);
  Future<String> createUser(String email, String password);
  Future<void> signOut();
}

class Auth implements BaseAuth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    User user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    //FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password));
    return user.uid;
  }

  Future<String> createUser(String email, String password) async {
    //FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password));
    //return user.uid;
  }

  Future<String> currentUser() async {
    //User user = _firebaseAuth.currentUser;
    //FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

}



class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {

    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }

    }

    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            new FlatButton(
                onPressed: _signOut,
                child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white))
            )
          ],
        ),
        body: new Center(
            //child: bubble_level(view:'top')//CameraScreen(flag:true,view: 'top')
        )
    );
  }
}



class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.onSignIn}) : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  static final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _name;
  String _last_name;
  FormType _formType = FormType.login;
  String _authHint = '';

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userId = _formType == FormType.login
            ? await widget.auth.signIn(_email, _password)
            : await widget.auth.createUser(_email, _password);
        setState(() {
          _authHint = 'Signed In\n\nUser id: $userId';
        });
        widget.onSignIn();
      }
      catch (e) {
        setState(() {
          _authHint = 'Sign In Error\n\n${e.toString()}';
        });
        print(e);
      }
    } else {
      setState(() {
        _authHint = '';
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

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _authHint = '';
    });
  }

  List<Widget> usernameAndPassword() {
    switch (_formType) {
      case FormType.login:
        return [
          Column(children:[
            Container(child:Text('Login')),
            Container(child:Text('Welcome back!')),
           padded(
              child: new TextFormField(
                key: new Key('email'),
                decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 24.0),
                    labelText: "Email",
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
                        color: Colors.teal,
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
                labelText: "Password",
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
                    color: Colors.teal,
                    width: 2.0,
                  ),
                ), hintText: 'Password'),
            obscureText: true,
            autocorrect: false,
            validator: (val) =>
            val.isEmpty
                ? 'Password can\'t be empty.'
                : null,
            onSaved: (val) => _password = val,
          ))

          ]),
        ];
      case FormType.register:
        return [
          Column(children: [

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
                      color: Colors.teal,
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
                    color: Colors.teal,
                    width: 2.0,
                  ),
                ), hintText: 'Password'),
            obscureText: true,
            autocorrect: false,
            validator: (val) =>
            val.isEmpty
                ? 'Password can\'t be empty.'
                : null,
            onSaved: (val) => _password = val,
          )),
           padded(child: new TextFormField(
            key: new Key('confirm password'),
            decoration: new InputDecoration(
                contentPadding: const EdgeInsets.only(left: 24.0),
                //labelText: "Confirm password",
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
                    color: Colors.teal,
                    width: 2.0,
                  ),
                ), hintText: 'Confirm password'),
            obscureText: true,
            autocorrect: false,
            validator: (val) =>
            val.isEmpty
                ? 'Password can\'t be empty.'
                : null,
            onSaved: (val) => _password = val,
          )),
           Container(alignment:Alignment.centerLeft, padding: const EdgeInsets.only(left:8.0), child:RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w400,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: '* ',style: TextStyle(color: Colors.red)),
                  TextSpan(text: 'Password must contain:',style: TextStyle(fontWeight:FontWeight.w600)),
                  TextSpan(text: '\n'+ String.fromCharCode(0x2022)+' At least 8 characters'+ '\n' + String.fromCharCode(0x2022)
                           + ' Both uppercase and lowercase letters'+ '\n' + String.fromCharCode(0x2022)+ ' At least one number'
                           + '\n' + String.fromCharCode(0x2022) + ' At least one special character')
                ],
              ),
            )),
          ]),
        ];
    }

  }

  List<Widget> submitWidgets() {
    switch (_formType) {
      case FormType.login:
        return [
          new PrimaryButton(
              key: new Key('login'),
              text: 'SUBMIT',
              height: 48.0,
              onPressed: validateAndSubmit
          ),
          new FlatButton(
              key: new Key('forgot-password'),
              child: new Text("Forgot your password?"),
              onPressed: moveToRegister
          ),
        ];
      case FormType.register:
        return [
          new PrimaryButton(
              key: new Key('register'),
              text: 'SUBMIT',
              height: 48.0,
              onPressed: validateAndSubmit
          ),
          new FlatButton(
              key: new Key('need-login'),
              child: new Text("Have an account? Login"),
              onPressed: moveToLogin
          ),
        ];
    }
    return null;
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
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          title: new Text(widget.title),
        ),
        backgroundColor: Colors.white,
        body: Column(
                children: [
                  //new Card(elevation: 0,
                  Container(padding: const EdgeInsets.all(16.0), width:double.infinity,height:80, color:Colors.teal, child:
                   Text("Connect With Email",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        //fontStyle: FontStyle.italic,
                        fontFamily: 'Barlow',
                        fontSize: 32),
                  )),
                  Container(padding: const EdgeInsets.all(16.0), width:double.infinity,height:50, child:
                   Text('Almost there! Create your login info.',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        //fontStyle: FontStyle.italic,
                        fontFamily: 'Barlow',
                        fontSize: 16),
                  )),
                      //new Column(
                      //    mainAxisSize: MainAxisSize.min,
                      //    children: <Widget>[
                            new Container(
                                padding: const EdgeInsets.only(left:16.0,right:16),
                                child: new Form(
                                    key: formKey,
                                    child: new Column(
                                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: usernameAndPassword() + submitWidgets(),
                                    )
                                )
                            ),
                         // ])
                  //),
                  //hintText()
                ]
            )
        //))
    );
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
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
      child: new RaisedButton(
          child: new Text(text, style: new TextStyle(color: Colors.white, fontSize: 20.0)),
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

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
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
        );
      case AuthStatus.signedIn:
        return new HomePage(
            auth: widget.auth,
            onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn)
        );
    }
  }
}

class z3a_ui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Get Set Up'),
          backgroundColor: Colors.teal,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          )),
      body: Center(

        child: Column(children: [

          Container(width:double.infinity,height:80,color: Colors.teal,child:
          Text("Connect With Email",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                //fontStyle: FontStyle.italic,
                fontFamily: 'Barlow',
                fontSize: 32),
          )),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 16),
              children: <TextSpan>[
                TextSpan(text: 'Create your account or'),
                TextSpan(text: ' log in here', style: TextStyle(color:HexColor('#00CED3')))
              ],
            ),
          ),
          new TextFormField(
                key: new Key('email'),
                decoration: new InputDecoration(labelText: 'Email'),
                autocorrect: false,
                validator: (val) => val.isEmpty ? 'Email can\'t be empty.' : null,
                //onSaved: (val) => _email = val,
              ),


          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w400,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 12),
              children: <TextSpan>[
                TextSpan(text: '_______'),
                TextSpan(text: '\n\n By logging in, you agree to the'),
                TextSpan(text: '\n privacy policy and terms of service', style: TextStyle(fontWeight:FontWeight.w600))
              ],
            ),
          ),
        ]
        ),

      ),

    );

  }
}

