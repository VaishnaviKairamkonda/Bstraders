import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Bungee',
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.amberAccent, fontSize: 24),
        ),
      )
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 01,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.asset(
        'assets/icon.png',
        width: 100,
        height: 100,
      ),
      backgroundColor: Colors.amber,
      photoSize: 100.0,
      loaderColor: Colors.amberAccent,

    );

  }

}

class AfterSplash extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<AfterSplash> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(
        // Enter your custom url

        url: "https://prakashsales.com/App/",
        // invalidUrlRegex: '^whatsapp:',
        withJavascript: true,
        withLocalStorage: true,
        enableAppScheme: true,
        primary: true,
        supportMultipleWindows: true,
        allowFileURLs: true,
        withLocalUrl: true,
        scrollBar: true,
        appCacheEnabled: true,
      ),

    );
  }
  SharedPreferences prefs;

  @override
  void initState() {

    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {

      log('load Data '+ url);
      Future<String> getPagesData(int page) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('myData$page');
      }
      if (url.startsWith('whatsapp:') || url.startsWith('upi://pay')) {
        // print('Step1:' + url);
        // log('load Data'+url);
        // debugPrint("Data");
        _launchURL(url);
        flutterWebviewPlugin.stopLoading();
        flutterWebviewPlugin.reload();
      }
    });

  }

  Future<String> setPagesData(int page, String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('myData$page', url);
  }
}
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}