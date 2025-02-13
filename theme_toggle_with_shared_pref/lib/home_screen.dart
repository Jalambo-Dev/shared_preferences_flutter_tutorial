import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final void Function() toogleTheme;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.toogleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences Theme Toggle'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 18,
          children: [
            Text('Press to change theme  :'),
            IconButton(
              onPressed: () {
                toogleTheme();
              },
              icon: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: 42,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
