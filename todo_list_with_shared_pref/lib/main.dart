import 'package:flutter/material.dart';
import 'package:todo_list_with_shared_pref/helper/cache_helper.dart';
import 'package:todo_list_with_shared_pref/home_screen.dart';
import 'package:todo_list_with_shared_pref/helper/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<CacheHelper>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
