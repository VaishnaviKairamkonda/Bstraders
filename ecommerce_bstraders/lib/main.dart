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
      seconds: 5,
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
        scrollBar: false,
        appCacheEnabled: true,
      ),

    );
  }

}

// WebView(
// initialUrl: 'https://prakashsales.com/App/',
// javascriptMode: JavascriptMode.unrestricted,
// navigationDelegate: (NavigationRequest request)
// {
// if (request.url.startsWith('com.phonepe.app'))
// {
// print('blocking navigation to $request}');
// _launchURL('https://my.redirect.url.com');
// return NavigationDecision.prevent;
// }
//
// print('allowing navigation to $request');
// return NavigationDecision.navigate;
// },
// )
// class StreamSubscription<WebViewStateChanged> _onStateChanged;
//       _onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) async {
//       if (mounted) {
//       if (state.url.startsWith('whatsapp:') && state.type == WebViewState.abortLoad) {
//       if (await canLaunch(state.url)) {
//       await launch(state.url);
//       }
//       }
//       }
// });

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }}