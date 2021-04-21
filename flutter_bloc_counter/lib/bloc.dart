import 'dart:async';

class CounterBloc {
  final _incrementController = StreamController<void>();
  final _countController = StreamController<int>();

  var _count = 0;

  CounterBloc() {
    _incrementController.stream
      .map((v) => _count++)
      .pipe(_countController);
  }

  Sink<void> get increment => _incrementController.sink;
  Stream<int> get counter => _countController.stream;

  void dispose() async {
    await _incrementController.close();
    await _countController.close();
  }
}
