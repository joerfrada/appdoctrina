import 'package:appdoctrina/pages/login.dart';
import 'package:appdoctrina/values/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctrina Policial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MyColors.azul,
      ),
      home: const LoginPage(),
    );
  }
}
