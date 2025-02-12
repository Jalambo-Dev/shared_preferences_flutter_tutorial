import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  // Load counter value from SharedPreferences
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  // Save counter value to SharedPreferences
  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  void _incrementCounter() {
    setState(() => _counter++);
    _saveCounter();
  }

  void _decrementCounter() {
    setState(() => _counter--);
    _saveCounter();
  }

  void _resetCounter() {
    setState(() => _counter = 0);
    _saveCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preference Counter'),
      ),
      body: Center(
        child: Text(
          'counter value is \n $_counter',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 18,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _decrementCounter,
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: _resetCounter,
            child: const Icon(Icons.exposure_zero),
          ),
        ],
      ),
    );
  }
}
