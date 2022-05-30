import 'dart:math';
import 'package:flutter/material.dart';

class Stop extends StatefulWidget {
  bool find;
  int i;
  Stop({required this.find, required this.i});
  @override
  State<Stop> createState() => _StopState();
}

class _StopState extends State<Stop> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
            widget.i % 2 == 0 ? 'assets/spotleft.jpg' : 'assets/spotright.jpg',
            fit: BoxFit.cover,
            width: 100),
        widget.find == false
            ? Container(
                alignment: widget.i % 2 == 0
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                margin: widget.i % 2 == 0
                    ? EdgeInsets.only(top: 7, bottom: 7, right: 8)
                    : EdgeInsets.only(top: 7, bottom: 7, left: 8),
                // margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: Image.asset(
                  widget.i % 2 == 0 ? 'assets/car1.png' : 'assets/car5.png',
                ),
              )
            : Center(),
        Container(
            alignment:
                widget.i % 2 == 0 ? Alignment.topLeft : Alignment.topRight,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            child: Text(
              "${widget.i}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )),
      ],
    );
  }
}
