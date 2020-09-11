import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

String selectedUrl = 'https://prakashsales.com/App/';


void main() {
  runApp(new MyHomePage());
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Instance of WebView plugin
  final flutterWebviewPlugin = new FlutterWebviewPlugin();


  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;
  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();


    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.startsWith('mailto:')) {
        _launchURL(url);
        flutterWebviewPlugin.stopLoading();
        flutterWebviewPlugin.reload();
      }
      else if (url.startsWith('tel:')) {
        _launchURL(url);
        flutterWebviewPlugin.stopLoading();
        flutterWebviewPlugin.reload();
      } else if (url.startsWith('whatsapp:') || url.startsWith('api.')) {
        _launchURL(url);
        flutterWebviewPlugin.stopLoading();
        flutterWebviewPlugin.reload();
      }
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onUrlChanged.cancel();
    flutterWebviewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: selectedUrl,

    );
  }

}
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }}
