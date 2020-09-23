import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';

import 'package:device_id/device_id.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/rendering.dart';
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
  String _deviceid = 'Unknown';


  @override
  void initState() {
    super.initState();
    initDeviceId();
  }

  Future<void> initDeviceId() async {
    String deviceid;
    String imei;
    String meid;

    deviceid = await DeviceId.getID;
    try {
      imei = await DeviceId.getIMEI;
      meid = await DeviceId.getMEID;
    } on PlatformException catch (e) {
      print(e.message);
    }

    if (!mounted) return;

    setState(() {
      _deviceid = '$deviceid';

      // _deviceid = 'Your deviceid: $deviceid\nYour IMEI: $imei\nYour MEID: $meid';
      log("device ID: "+ _deviceid);
    });
  }
  addData(){
    Map<String,dynamic> demoData = {"DeviceId":_deviceid};
    CollectionReference collectionReference = Firestore.instance.collection('Users');
    collectionReference.add(demoData);

  }
  @override
  Widget build(BuildContext context) {
    addData();
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
        url: "https://servigo.in/",

        // invalidUrlRegex: '^whatsapp:',
        withJavascript: true,
        withLocalStorage: true,
        enableAppScheme: true,
        primary: true,
        supportMultipleWindows: true,
        allowFileURLs: true,
        withLocalUrl: true,
        scrollBar: true,
        hidden: false,
        clearCookies: true,
        appCacheEnabled: true,

      ),

    );
  }

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
  }
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