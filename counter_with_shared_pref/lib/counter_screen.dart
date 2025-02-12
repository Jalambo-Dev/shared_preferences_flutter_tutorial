import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  /// Initialize [_prefs] and load the value of the 'counter' preference,
  /// updating the state of this widget with the loaded value.
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() => _counter = _prefs.getInt('counter')!);
  }

  /// Updates the counter with the given [value] and persists it to shared preferences.
  ///
  /// This method updates the [_counter] state variable with the provided [value],
  /// and then saves the updated counter value to shared preferences using the key 'counter'.
  ///
  /// [value] - The new value to set the counter to.
  void _updateCounter(int value) {
    setState(() => _counter = value);
    _prefs.setInt('counter', _counter);
  }

  void _incrementCounter() => _updateCounter(++_counter);
  void _decrementCounter() => _updateCounter(--_counter);
  void _resetCounter() => _updateCounter(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preference Counter'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'counter value is',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ],
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
            child: const Icon(CupertinoIcons.restart),
          ),
        ],
      ),
    );
  }
}
