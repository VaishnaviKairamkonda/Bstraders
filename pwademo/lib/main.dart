import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() {
  runApp(MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Bungee',
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.black38, fontSize: 24),
        ),
      )
  ));
  // runApp(new MyHomePage());
}



class MyHomePage extends StatefulWidget {
  @override
  GetCurrentURLWebViewState createState() {
    return new GetCurrentURLWebViewState();
  }
}

class GetCurrentURLWebViewState extends State<MyHomePage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription<String> _onUrlChanged;
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      key: scaffoldKey,
      url: 'https://servigo.in/',
      hidden: true,
      appBar: AppBar(title: Text("Current Url")),
    );
  }
  @override
  void initState() {
    super.initState();

    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        print("Current URL: $url");
        if (url.startsWith('mailto:') || url.startsWith('tel:')) {
          // print('Step1:' + url);
           log('load Data'+url);
          // debugPrint("Data");
          _launchURL(url);
          flutterWebviewPlugin.stopLoading();
          flutterWebviewPlugin.reload();
        }
      }
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }


}
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
  else {
    throw 'Could not launch $url';
  }
}