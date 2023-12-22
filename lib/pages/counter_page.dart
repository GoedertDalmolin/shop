import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
  });

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo Contador'),
      ),
      body: Column(
        children: [
          Text((CounterProvider.of(context)?.counterState.value ?? 0).toString()),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.counterState.increment();
              });
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.counterState.decrement();
              });
            },
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
