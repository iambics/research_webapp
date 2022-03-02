import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({this.key, this.text, this.height, this.width, this.onPressed}) : super(key: key);
  final Key key;
  final String text;
  final double height;
  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: BoxConstraints.expand(height: height,width: width),
      child: ButtonTheme(minWidth: width, height: height,child: FlatButton(
          child: new Text(text, style: TextStyle(letterSpacing: 1.5,
              color: HexColor('#FFFFFF'),
              fontWeight: FontWeight.w700,
              fontFamily: 'Barlow',
              fontSize: 16),),
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(height / 2))),
          color: Colors.black,
          textColor: Colors.black87,
          onPressed: onPressed),
    ));
  }
}