import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatefulWidget {
  ClockWidget({Key key}) : super(key: key);

  @override
  ClockWidgetState createState() => ClockWidgetState();
}

class ClockWidgetState extends State<ClockWidget> {
  var _nowTime = DateTime.now();
  final _dateFormat = new DateFormat.Hms();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 33),
        (Timer timer) => setState(() => _nowTime = DateTime.now()));
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var text = _dateFormat.format(_nowTime);
    var fontSize = MediaQuery.of(context).size.width * 0.15;
    return Stack(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
              fontSize: fontSize,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = Colors.black),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
          ),
        )
      ],
    );
  }
}
