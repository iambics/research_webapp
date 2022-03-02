import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '/T2.dart';

void main() {
  runApp(MaterialApp(
    home: T1(),

  ));
}

class T1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Align(alignment: Alignment(-0.25,0), child:Text("Get Set Up")),
             backgroundColor:HexColor('#A5E0E5'),
            //centerTitle: true,
             leading: IconButton(icon:Icon(Icons.arrow_back),
             //onPressed:() => Navigator.pop(context, false),
             onPressed:() => Navigator.pop(context)),
          ),
           body:
          ListView(children:[Column(mainAxisSize: MainAxisSize.min,children:[
                 Container(
                   padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
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
                  menuitem('US Letter Paper', '8.5" X 11" smooth, blank, white paper', '(no wrinkles!)', 'assets/images/icon_setup1_paper.png'),
                  Divider(color: Colors.black),
                  menuitem('Lighting', 'Bright, even lighting', '(no heavy shadows!)','assets/images/icon_setup2_lighting.png'),
                  Divider(color: Colors.black),
                  menuitem('Flat Surface', 'Hard, dark floor', '(no carpet!)', 'assets/images/icon_setup3_surface.png'),
                  Divider(color: Colors.black),
                  menuitem('Bare feet & ankles', 'Roll up clothing above your ankles', '(no socks!)', 'assets/images/icon_setup4_barefeet.png'),
                  Divider(color: Colors.black),
                  menuitem('Pen', 'Ready to make its mark', '(no highlighters!)', 'assets/images/Icon_Pen.png'),
            Expanded(child:Align(alignment: FractionalOffset.bottomRight, child: FlatButton(
                onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => T2()),
                );},
                child: Text('GOT IT', style: new TextStyle(fontSize: 17.0, color: HexColor('#00CED3')))))
            )
                ]

          )]),
       ),
    );

  }
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
            imagepath, fit: BoxFit.cover),
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
      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
    );
  }
}


//Navigator.pop(context, 'Yep!');
//Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
