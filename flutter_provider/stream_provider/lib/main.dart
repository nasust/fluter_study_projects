import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class CounterBloc {
  final _incrementController = StreamController<void>();
  final _countController = StreamController<int>();

  var _count = 0;

  CounterBloc() {
    _incrementController.stream.map((v) => _count++).pipe(_countController);
  }

  Sink<void> get increment => _incrementController.sink;
  Stream<void> get counter => _countController.stream;

  void dispose() async {
    await _incrementController.close();
    await _countController.close();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  _MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Stream Count:',
            ),
            StreamProvider<int>(
              initialData: 0,
              create: (_) => Stream<int>.periodic(Duration(seconds: 1), (count) => count + 1),
              child: Consumer<int>(builder: (_, counter, __) {
                return Text(
                  "$counter",
                  style: Theme.of(context).textTheme.headline4,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
