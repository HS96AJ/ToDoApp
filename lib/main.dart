import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/Pages/main_page.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox("myBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true
      ),
      darkTheme: ThemeData.dark(useMaterial3: true) ,
      home: const HomePage(),
    );
  }
}