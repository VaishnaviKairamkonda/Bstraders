import 'package:flutter/material.dart';
import 'package:flutter_appdata/random_words.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue[900]),
      home: RandomWords()
    );
  }
}

