import 'package:flutter/material.dart';
class SlideRoute extends PageRouteBuilder {
  final Widget page;
  final int duration;
  final String direction;
  SlideRoute({this.page,this.duration,this.direction})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionDuration: Duration(milliseconds: duration),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: direction=='Left'? const Offset(1, 0):direction=='Right'?const Offset(-1, 0):direction=='Up'?const Offset(0, 1):const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

