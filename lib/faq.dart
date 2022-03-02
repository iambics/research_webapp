import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Align(alignment: Alignment(-0.20, 0.5),
                child: Text(
                    "FAQ", style: TextStyle(color: HexColor('#222222')))),
            backgroundColor: HexColor('#A5E0E5'),
            //centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back), color: HexColor('#222222'),
                onPressed: () => Navigator.pop(context)),
          ),

          body:
          Stack(children: [
            Container(
                //padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                width: double.infinity,
                height: double.infinity,
                child: Image.asset('assets/images/bg_scan_v1.png', fit: BoxFit.fill)),
            Container(padding: EdgeInsets.all(20.0), child:ListView(children:[
              ExpandableText(q:'What is Iambic?\n',a:'\nIambic removes the guesswork from online\nshoe shopping by virtualizing the fitting\nprocess.'),
              SizedBox(height:10),
              ExpandableText(q:'Who is behind Iambic?\n',a:'\nIambic’s core team consists of experts in 3D modeling, biomechanics, computer vision, machine learning, material science, retail strategy and user-centered design who share a dedication to mastering the art of footwear fit, for all walks of life.'),
              SizedBox(height:10),
              ExpandableText(q:'Is Iambic right for me?\n',a:"\nHave you ever purchased shoes online, only to deal with returns and exchanges? Iambic can eliminate the trial-and-error from the process."
                  "Two out of every three people wear shoes that don’t actually fit, and evidence shows this leads to discomfort and eventually injuries and permanent damage."
                  "Iambic’s software analyzes all the intricacies of your feet, and of the shoes with our partnered brands and retailers to take the guesswork out of shopping online."
                  "The right size shoe for every walk of life is the first step towards lifelong mobility."
                  "Iambic is for anyone who wants to make their life easier, and more comfortable."),
              SizedBox(height:10),
              ExpandableText(q:'What do you do with my data?\n',a:'\nThrough the Virtual Fit Assessment, we gather the data necessary to generate footwear recommendations personalized to your needs. The more data you provide, the more accurate the results will be.'),
              SizedBox(height:10),
              ExpandableText(q:'How do I delete my Iambic account?\n',a:'\nFrom the Home page, tap to open the menu in the upper left corner, then tap settings, and then tap the DELETE ACCOUNT button for further details.'),
              SizedBox(height:10),
              ExpandableText(q:'Can I ask more questions?\n',a:'\nYes, of course! You can email us anytime at connect@iambichealth.com.'),




            ])
            ),
            //Divider(color: Colors.black),

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
  bool _isExpanded = true;

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
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: HexColor('#222222')),
        )
        ),
        secondChild: RichText(text:
        TextSpan(
            text: widget.q,
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: HexColor('#222222')),
            children: <InlineSpan>[
              TextSpan(
                text: widget.a,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: HexColor('#222222')),
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
    home: faq(),

  ));
}


//maxLines: _isExpanded ? null : 1,
