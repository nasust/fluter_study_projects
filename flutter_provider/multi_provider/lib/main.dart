import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class FirstCounterBloc {
  final _incrementController = StreamController<void>();
  final _countController = StreamController<int>();

  var _count = 0;

  FirstCounterBloc() {
    _incrementController.stream.map((v) => _count++).pipe(_countController);
  }

  Sink<void> get increment => _incrementController.sink;
  Stream<void> get counter => _countController.stream;

  void dispose() async {
    await _incrementController.close();
    await _countController.close();
  }
}

class SecondCounterBloc {
  final _incrementController = StreamController<void>();
  final _countController = StreamController<int>();

  var _count = 0;

  SecondCounterBloc() {
    _incrementController.stream.map((v) => _count++ * 100).pipe(_countController);
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
      home: MultiProvider(
        providers: [
          Provider<FirstCounterBloc>(
            create: (context) => FirstCounterBloc(),
            dispose: (context, bloc) => bloc.dispose(),
          ),
          Provider<SecondCounterBloc>(
            create: (context) => SecondCounterBloc(),
            dispose: (context, bloc) => bloc.dispose(),
          ),
        ],
        child: _MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
              'You have pushed the button this many times:',
            ),
            _BlocCounterText(),
          ],
        ),
      ),
      floatingActionButton: Consumer2<FirstCounterBloc, SecondCounterBloc>(
        builder: (_, firstBloc, secondBloc, __) {
          return FloatingActionButton(
            onPressed: () {
              firstBloc.increment.add(null);
              secondBloc.increment.add(null);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}

class _BlocCounterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firstBloc = Provider.of<FirstCounterBloc>(context, listen: false);
    final secondBloc = Provider.of<SecondCounterBloc>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<int>(
          stream: firstBloc.counter,
          initialData: 0,
          builder: (context, snapshot) {
            return Text(
              '${snapshot.data} : ',
              style: Theme.of(context).textTheme.headline4,
            );
          },
        ),
        StreamBuilder<int>(
          stream: secondBloc.counter,
          initialData: 0,
          builder: (context, snapshot) {
            return Text(
              '${snapshot.data}',
              style: Theme.of(context).textTheme.headline4,
            );
          },
        ),
      ],
    );
  }
}
