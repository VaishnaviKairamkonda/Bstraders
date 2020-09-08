import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: MyApp1(),

    );
  }
}
class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: "https://servigo.in/"


    );
  }
}