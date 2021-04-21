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
      home: Provider<CounterBloc>(
        create: (context) => CounterBloc(),
        dispose: (context, bloc) => bloc.dispose(),
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
            Consumer<CounterBloc>(builder: (_, bloc, __) {
              return StreamBuilder<int>(
                stream: bloc.counter,
                initialData: 0,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Consumer<CounterBloc>(
        builder: (_, bloc, __) {
          return FloatingActionButton(
            onPressed: () => bloc.increment.add(null),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
