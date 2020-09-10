import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:upi_pay/upi_pay.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
      home: GetCurrentURLWebView(),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   fontFamily: 'Bungee',
      //   primaryTextTheme: TextTheme(
      //     title: TextStyle(color: Colors.amberAccent, fontSize: 24),
      //   ),
      // )
  ));
}

class GetCurrentURLWebView extends StatefulWidget {
  @override
  GetCurrentURLWebViewState createState() {
    return new GetCurrentURLWebViewState();
  }
}
class GetCurrentURLWebViewState extends State<GetCurrentURLWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription<String> _onUrlChanged;

  @override
  void initState() {
    super.initState();
    // _onUrlChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) async {
    //   if (mounted) {
    //     if (state.url.startsWith('whatsapp:') && state.type == WebViewState.abortLoad) {
    //       if (await canLaunch(state.url)) {
    //         await launch(state.url);
    //       }
    //     }
    //   }
    // });
     _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
       if (mounted) {
         print("Current URL: $url");
       }
     });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      key: scaffoldKey,
      url: 'https://prakashsales.com/App/',
      hidden: true,
      appBar: AppBar(title: Text("Current Url")),
    );
  }

}
