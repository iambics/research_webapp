//import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_line/dotted_line.dart';
import '/T4.dart';
import '/slide_transition.dart';


void main() => runApp(MyApp2());

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      home: TutorialList2(arg1: 'current',arg2: 'upcoming',arg3:'upcoming'),
    );
  }
}

class TutorialList2 extends StatefulWidget {
  final String arg1,arg2,arg3;
  TutorialList2({this.arg1,this.arg2,this.arg3});
  @override
  TutorialList2State createState() => TutorialList2State();
}
//double width;
//double height;
class TutorialList2State extends State<TutorialList2> {

  //String status;
  String _status1='current';
  String _status2='upcoming';
  String _status3='upcoming';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  setColor(String status){
    Color color;
    switch(status) {
      case 'current':
        return color=HexColor('#00CED3');
      case 'upcoming':
        return color=HexColor('#FFFFFF');
      case 'viewed':
        return color=HexColor('#00CED3').withOpacity(0.2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    _status1=widget.arg1;
    _status2=widget.arg2;
    _status3=widget.arg3;
    return Scaffold(key: _scaffoldKey,
      appBar: AppBar(
        //title: Text('Get Set Up'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          )),
      body: Stack(children: <Widget> [

        Image(
          image: AssetImage('assets/images/bgT0.png'),
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),

        Align(child:Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,children: [
          Stack(
            children:[
              Align(alignment:Alignment.topCenter,child:
               SizedBox(height:48,width: 328.0*width/360, child:FlatButton(
                onPressed: () {
                  //_navigateAndDisplaySelection(context);
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => T1()),
                    SlideRoute(page: T1(),duration: 600,direction: 'Left'),
                  );
                  },
                color: _status1=='current' ? HexColor('#00CED3') : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Container(alignment: Alignment.centerLeft, padding:EdgeInsets.only(left:55),child:Text('Get Set Up',
                  style: TextStyle(
                      color: _status1=='current' ? HexColor('#222222') :HexColor('#969696'),//Colors.grey[800],
                      fontWeight: _status1=='current' ? FontWeight.w700 : FontWeight.w500,
                      //fontStyle: FontStyle.italic,
                      fontFamily: 'Barlow',
                      fontSize: 23),),
              )))),

              Positioned(top:0,left: 20,child:ClipOval(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: setColor(_status1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(width: 2,color: HexColor('#00CED3'),style: BorderStyle.solid),
                    ),
                    child: _status1=='viewed' ? Icon(Icons.check, color: HexColor('#00CED3'))
                        :Center(child:Text('1',
                      style: TextStyle(
                          color: _status1=='current' ? HexColor('#FFFFFF') :HexColor('#A5E0E5'),
                          fontWeight: _status1=='current' ? FontWeight.w700 : FontWeight.w500,
                          //fontStyle: FontStyle.italic,
                          fontFamily: 'Barlow',
                          fontSize: 18),
                    )),
                  ))),


              Positioned(top:12, left:width-60, child:IgnorePointer(ignoring: true,
                child:Icon(Icons.arrow_forward,
                color: _status1=='current' ? HexColor('#FFFFFF'): Colors.transparent,
              ))),


            ],
          ),
          Container(alignment: FractionalOffset.centerLeft ,padding:EdgeInsets.only(left:42), child:DottedLine(
            direction: Axis.vertical,
            lineLength: 35,
            lineThickness: 2.0,
            dashLength: 5.0,
            dashColor: HexColor('#A5E0E5'),
            dashGapLength: 4.0,
            dashGapColor: Colors.transparent,
          )),

          Stack(
            children:[
              Center(child:
               SizedBox(height:48,width: 328.0*width/360, child:FlatButton(
                onPressed: () {if(_status1=='viewed')
                  _navigateAndDisplaySelection2(context);},
                color: _status2=='current' ? HexColor('#00CED3') : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Container(alignment: Alignment.centerLeft, padding:EdgeInsets.only(left:42),child:Text('  Scan Right Foot',textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _status2=='current' ? HexColor('#222222') :HexColor('#969696'),//Colors.grey[800],
                      fontWeight: _status2=='current' ? FontWeight.w700 : FontWeight.w500,
                      //fontStyle: FontStyle.italic,
                      fontFamily: 'Barlow',
                      fontSize: 23),),
              )))),

              Positioned(top:0,left: 20,child:ClipOval(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: setColor(_status2),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(width: 2,color: _status2=='upcoming'? HexColor('#A5E0E5'):HexColor('#00CED3'),style: BorderStyle.solid),
                    ),
                    child: _status2=='viewed' ? Icon(Icons.check, color: HexColor('#00CED3'))
                        :Center(child:Text('2',
                      style: TextStyle(
                          color: _status2=='current' ? HexColor('#FFFFFF') :HexColor('#A5E0E5'),
                          fontWeight: _status2=='current' ? FontWeight.w700 : FontWeight.w500,
                          //fontStyle: FontStyle.italic,
                          fontFamily: 'Barlow',
                          fontSize: 18),
                    )),
                  ))),


              Positioned(top:12, left:width-60, child: IgnorePointer(ignoring: true,
                  child:Icon(Icons.arrow_forward,
                color: _status2=='current' ? HexColor('#FFFFFF'): Colors.transparent,
              ))),


            ],
          ),

          Container(alignment: FractionalOffset.centerLeft ,padding:EdgeInsets.only(left:42), child:DottedLine(
            direction: Axis.vertical,
            lineLength: 35,
            lineThickness: 2.0,
            dashLength: 5.0,
            dashColor: HexColor('#A5E0E5'),
            dashGapLength: 4.0,
            dashGapColor: Colors.transparent,
          )),
          Stack(
            children:[
              Center(child:
               SizedBox(height:48,width: 328.0*width/360, child:FlatButton(
                onPressed: () {if(_status1=='viewed'&&_status2=='viewed')
                  _navigateAndDisplaySelection3(context);},
                color: _status3=='current' ? HexColor('#00CED3') : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Container(alignment: Alignment.centerLeft, padding:EdgeInsets.only(left:52),child:Text('Scan Left Foot',textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _status3=='current' ? HexColor('#222222') :HexColor('#969696'),//Colors.grey[800],
                      fontWeight: _status3=='current' ? FontWeight.w700 : FontWeight.w500,
                      //fontStyle: FontStyle.italic,
                      fontFamily: 'Barlow',
                      fontSize: 23),),
              )))),

              Positioned(top:0,left: 20,child:ClipOval(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: setColor(_status3),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(width: 2,color: _status3=='upcoming'? HexColor('#A5E0E5'):HexColor('#00CED3'),style: BorderStyle.solid),
                    ),
                    child: _status3=='viewed' ? Icon(Icons.check, color: HexColor('#00CED3'))
                        :Center(child:Text('3',
                      style: TextStyle(
                          color: _status3=='current' ? HexColor('#FFFFFF') :HexColor('#A5E0E5'),
                          fontWeight: _status3=='current' ? FontWeight.w700 : FontWeight.w500,
                          //fontStyle: FontStyle.italic,
                          fontFamily: 'Barlow',
                          fontSize: 18),
                    )),
                  ))),


              Positioned(top:12, left:width-60, child: IgnorePointer(ignoring: true,
                  child:Icon(Icons.arrow_forward,color: _status3=='current' ? HexColor('#FFFFFF'): Colors.transparent,
              ))),


            ],
          ),


        ],

        )),

        Positioned(top:20, left:30,child:Text("Let's Get\nYou Started", style: TextStyle(
            color: HexColor('#222222'),//Colors.grey[800],
            fontWeight: FontWeight.w600,
            //fontStyle: FontStyle.italic,
            fontFamily: 'Barlow',
            fontSize: 32))),
        if(_status1=='current')
        Positioned(top:120, left:30,child:Text("Estimated time remaining: 15 minutes")),
      ],

      ),
    );
  }
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      //MaterialPageRoute(builder: (context) => T1()),
      SlideRoute(page: T1(),duration: 600,direction: 'Left'),
    );



    if (result=='Yep') {
      setState(() {
        _status1='viewed';
        _status2='current';
      });
    }else{
      setState(() {
        _status1=_status1;
      });
    }


    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }


  _navigateAndDisplaySelection2(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      //MaterialPageRoute(builder: (context) => T4()),
        SlideRoute(page: T4(),duration: 600,direction: 'Left'),
    );


    if (result=="Yep!") {
      setState(() {
        _status2='viewed';
        _status3='current';
      });
    }else{
      setState(() {
        _status2=_status2;
      });
    }


    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }

  _navigateAndDisplaySelection3(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      //MaterialPageRoute(builder: (context) => T7A()),
      SlideRoute(page: T7A(),duration: 600,direction: 'Left'),
    );


    if (result=="Yep!") {
      setState(() {
        _status3='viewed';
      });
    }else{
      setState(() {
        _status3=_status3;
      });
    }


    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
                  Navigator.pop(context, 'Yep!');
                },
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Nope!" as the result.
                  Navigator.pop(context, 'Nope.');
                },
                child: Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}


