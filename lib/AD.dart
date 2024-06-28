import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onetv/b.dart';
import 'package:onetv/fit.dart';

import 'dart:async';

import 'package:uni_links3/uni_links.dart';


/*class link extends StatefulWidget {
  @override
  _linkState createState() => _linkState();
}

class _linkState extends State<link> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> initUniLinks() async {
    try {
      final  initialLink = await getInitialLink();
      if (initialLink != null) {
        handleLink(Uri.parse(initialLink));
      }
    } on PlatformException {
      // Handle exception
    }

    _sub = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      if (uri != null) {
        handleLink(uri);
      }
    }, onError: (err) {
      // Handle error
    });
  }

  void handleLink(Uri uri) {
    String videoUrl = uri.queryParameters['url'] ?? '';
    String sd = uri.queryParameters['sd'] ?? '';
    String low = uri.queryParameters['low'] ?? '';
    String fhd = uri.queryParameters['fhd'] ?? '';
    print("============ahmed===============");
    print(videoUrl);
    print("==============1111=============");

    // Use the received data as needed
    VideoPlayersScreen(lowurl: low,sdurl: sd,fhdurl: fhd,hdurl: videoUrl,);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('UniLinks Example'),
        ),
        body: Center(
          child: Text('Waiting for deep link...'),
        ),
      ),
    );
  }
}*/
class DeepLinkHandlerPage extends StatefulWidget {
  @override
  _DeepLinkHandlerPageState createState() => _DeepLinkHandlerPageState();
}

class _DeepLinkHandlerPageState extends State<DeepLinkHandlerPage> {
  StreamSubscription? _sub;
  late String videoUrl;
  late String sd ;
  late String low ;
  late String fhd;
  bool _deepLinkOpened = false;

  @override
  void initState() {
    super.initState();
    initUniLinks();
    videoUrl;
    sd;
    low;
    fhd;
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        handleLink(Uri.parse(initialLink));
      }
    } on PlatformException {
      // Handle exception
    }

    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleLink(uri);
      }
    }, onError: (err) {
      // Handle error
    });
  }

  void handleLink(Uri uri) {
     videoUrl = uri.queryParameters['url'] ?? '';
     sd = uri.queryParameters['sd'] ?? '';
     low = uri.queryParameters['low'] ?? '';
     fhd = uri.queryParameters['fhd'] ?? '';

    setState(() {
      _deepLinkOpened = true;
      // You can save the received deep link data in variables if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_deepLinkOpened) {

      return
        VideoPlayersScreen(lowurl: low,sdurl: sd,fhdurl: fhd,hdurl: videoUrl,);// Assuming VideoPlayersScreen is the screen for playing videos
    } else {
      // If no deep link was opened, show the main screen
      return SplashScreen();
    }
  }
}
