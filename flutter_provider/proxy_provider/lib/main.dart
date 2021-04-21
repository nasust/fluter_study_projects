import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class Counter with ChangeNotifier {
  var _count = 0;

  void increment() {
    ++_count;
    notifyListeners();
  }

  int get counter => _count;
}

class CounterMessage {
  Counter _counter;

  CounterMessage({@required Counter counter}) {
    _counter = counter;
  }

  String get message => "Count ${_counter.counter} ";
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
          ChangeNotifierProvider<Counter>(create: (_) => Counter()),
          ProxyProvider<Counter, CounterMessage>(
            update: (_, counter, counterMessage) => CounterMessage(counter: counter),
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
            Consumer<CounterMessage>(
              builder: (_, counterMessage, __) {
                return Text(
                  counterMessage.message,
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<Counter>(
        builder: (_, counter, __) {
          return FloatingActionButton(
            onPressed: () {
              counter.increment();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
