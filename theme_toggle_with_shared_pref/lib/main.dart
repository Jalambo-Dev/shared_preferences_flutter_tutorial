import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_toggle_with_shared_pref/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      setState(() => _isDarkMode = _prefs.getBool('isDarkMode') ?? false);
    } catch (e) {
      log('Error loading preferences: $e');
    }
  }

  void _saveThemePrefs() => _prefs.setBool('isDarkMode', _isDarkMode);

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
    _saveThemePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(isDarkMode: _isDarkMode, toogleTheme: _toggleTheme),
    );
  }
}
