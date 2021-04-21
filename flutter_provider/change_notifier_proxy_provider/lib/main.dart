import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class Counter with ChangeNotifier {
  int _counter = 0;

  get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

class CounterMessage with ChangeNotifier {
  Counter _counter;

  void setCounter(Counter counter) {
    _counter = counter;
    notifyListeners();
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
      home: ChangeNotifierProvider(
        create: (_) => new Counter(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<Counter, CounterMessage>(
      create: (context) => CounterMessage(),
      update: (context, counter, counterMessage) => counterMessage..setCounter(counter),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
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
                    '${counterMessage.message}',
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
              onPressed: () => counter.increment(),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
