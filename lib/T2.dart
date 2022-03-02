import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '/Tutorial.dart';


class T2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home:  Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Align(alignment: Alignment(-0.25, 0.5),
            child: Text(
                "Get Set Up", style: TextStyle(color: HexColor('#222222')))),
        backgroundColor: HexColor('#FFFFFF'),
        //centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
            //onPressed:() => Navigator.pop(context, false),
            onPressed: () => Navigator.pop(context)),
      ),

      body:
      Column(children: [
        Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            width: 360,
            height: 358.2,
            child: Image.asset('assets/images/bg.png', fit: BoxFit.fill)),
        Container(padding: EdgeInsets.all(16.0), child:
         RichText(
          text: TextSpan(
            style: TextStyle(color: HexColor('#222222'),
                fontWeight: FontWeight.w600,
                //fontStyle: FontStyle.italic,
                fontFamily: 'Barlow',
                fontSize: 32),
            children: <TextSpan>[
              TextSpan(text: "What You'll Do"),
              TextSpan(
                  text: '\nWe’ll be taking 3 captures of each foot at different angles:',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
              TextSpan(text: " top, inner, outer.",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              TextSpan(text: '\n\nWe’ll guide you every step of the way!',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
            ],
          ),
        )),
        //Divider(color: Colors.black),
        Expanded(child:Align(alignment: FractionalOffset.bottomRight, child:FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TutorialList2(arg1: 'viewed',arg2: 'current',arg3: 'upcoming')),
              );
            },
           child: Text('GOT IT', style: new TextStyle(
                    fontSize: 17.0, color: HexColor('#00CED3')))))
        )
      ]

      )),

    );
    //);
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText({Key key,this.q,this.a}) : super(key: key);

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String q,a;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleOnTap,
      child:AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        crossFadeState: _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: RichText(maxLines: 1, text:
        TextSpan(
            text: widget.q,
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
         )
        ),
        secondChild: RichText(text:
        TextSpan(
            text: widget.q,
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
            children: <InlineSpan>[
              TextSpan(
                text: widget.a,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
              )
            ]
        )
        ),
      ),
    );
  }

  void _handleOnTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: ExpandableText(q:'What is Iambic?\n',a:'\nIambic removes the guesswork from online\nshoe shopping by virtualizing the fitting\nprocess.'),

  ));
}


//maxLines: _isExpanded ? null : 1,
