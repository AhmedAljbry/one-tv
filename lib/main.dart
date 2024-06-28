
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onetv/AD.dart';
import 'package:onetv/Screen/listPlaye.dart';
import 'package:onetv/b.dart';
import 'package:onetv/fit.dart';
import 'package:uni_links3/uni_links.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();


  StreamSubscription? _sub;

  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'otv',
      color: Colors.redAccent,
      theme: ThemeData(
          iconButtonTheme: IconButtonThemeData(style: ButtonStyle(iconSize: MaterialStatePropertyAll(20)),),
          appBarTheme: AppBarTheme(
            color: Colors.redAccent,
            titleTextStyle: TextStyle(color: Colors.white,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
      ),
      home:DeepLinkHandlerPage(),
        );


  }

}




