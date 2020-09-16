import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Bungee',
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.black38, fontSize: 24),
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
      seconds: 02,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.asset(
        'assets/icon.png',
        width: 100,
        height: 100,
      ),
      backgroundColor: Colors.black12,
      photoSize: 100.0,
      loaderColor: Colors.black38,

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

        url: "https://kukadi.newsoftprojects.com/App/",
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
/*
  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      log('load Data '+ url);
      if (url.contains('mail') ) {
        print(url);
        _launchURL("mailto:servigoservices@gmail.com");
        flutterWebviewPlugin.stopLoading();
        flutterWebviewPlugin.reload();
        // flutterWebviewPlugin.close();
      }
      else if(url.startsWith('tel:') || url.contains('upi://pay') )
      {
        _launchURL(url);
        log('load  '+ url);

        flutterWebviewPlugin.stopLoading();
        flutterWebviewPlugin.reload();
        // flutterWebviewPlugin.close();
      }
      else  if (url.contains('fb')) {
        _launchURL("fb://sharer.php?u=https://servigo.in/ServigoTodaysMenu.php");
        flutterWebviewPlugin.stopLoading();
        flutterWebviewPlugin.reload();
        // flutterWebviewPlugin.close();

      }
      else if (url.contains('whatsapp://send') ||url.contains('whatsapp://wa.me') ) {
        _launchURL(url);
        flutterWebviewPlugin.reload();
        flutterWebviewPlugin.stopLoading();
      }
    });
  }*/
}
_launchURL(String url) async {
  log('In Function '+ url);
  if (await canLaunch(url)) {
    log('In if '+ url);
    await launch(url);
  }
  else {
    log('In trow '+ url);
    throw 'Could not launch $url';
  }
}

