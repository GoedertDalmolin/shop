import 'package:flutter/cupertino.dart';

class CounterState {
  int _value = 0;

  increment() => _value++;
  decrement() => _value--;

  int get value => _value;

  bool diff(CounterState old) {
    return old._value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  final counterState = CounterState();

  CounterProvider({super.key, required super.child});

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.counterState.diff(counterState);
  }

}