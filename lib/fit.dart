import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onetv/Screen/comp.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:onetv/Screen/listPlaye.dart';
import 'package:onetv/b.dart';
import 'package:uni_links3/uni_links.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FlameSplashController? controller;

  StreamSubscription? _sub;


  @override
  void initState() {
    super.initState();

    controller = FlameSplashController(
      fadeInDuration: Duration(seconds: 1),
      fadeOutDuration: Duration(milliseconds: 250),
      waitDuration: Duration(seconds: 1),
      autoStart: false,
    );



    checkConnectivity();
    checkVPNStatus();
  }

  void checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    print(result.toString());
  }

  void checkVPNStatus() async {
    try {
      await FlutterVpn.prepare();
      var vpnStatus = await FlutterVpn.currentState;
      print('VPN Status: $vpnStatus');
      // اقم بتحديث حالة الاتصال بشبكة VPN هنا وفقًا لاحتياجاتك
    } catch (e) {
      print('Error checking VPN status: $e');
    }
  }



  @override
  void dispose() {
    controller!.dispose();
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/a.png",),
          fit: BoxFit.cover,

        ),

      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(215, 76, 76, 0),
        body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            if (snapshot.hasData) {
              ConnectivityResult? result = snapshot.data;
              if (result == ConnectivityResult.mobile) {
                return connected('Mobile');
              } else if (result == ConnectivityResult.wifi) {
                // تحقق من حالة الاتصال بشبكة VPN أيضًا إذا كنت ترغب
                return connected('WIFI');
              }
              else {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.warning,
                  text: "Your transaction was successful!",
                );
                return Container(color: Colors.white,);
              }
            } else {

              return loading();
            }
          },
        ),
      ),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget aa() {
    return FlameSplashScreen(
      showBefore: (BuildContext context) {
        return Image(image: AssetImage("assets/a.png"),fit: BoxFit.fitHeight,width: 200,height: 200);
      },
      onFinish: (context) =>
          navigatorfansh(context: context, widget: list()),
      controller: controller,
      theme: FlameSplashTheme(
        backgroundDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        logoBuilder: (context) =>
            Image(image: AssetImage("assets/a.png",),fit: BoxFit.fitHeight,width: 200,height: 200),
      ),
    );
  }

  Widget connected(String type) {
    // تأكد من حالة الاتصال بشبكة VPN هنا أيضًا وفقًا لاحتياجاتك
    return aa();
  }

  Widget noInternet() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assaets/no_internet.png',
            color: Colors.amber,
            height: 100,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text(
              "انت لست متصل بالانترنت تاكد من اتصالك",
              style: TextStyle(fontSize: 22),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const Text("تاكد من توصيل عب الانترنت."),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.amber),
            ),
            onPressed: () async {
              // يمكنك أيضًا التحقق من الاتصال بالإنترنت مرة أخرى هنا
              ConnectivityResult result = await Connectivity().checkConnectivity();
              print(result.toString());
            },
            child: const Text("Refresh"),
          ),
        ],
      ),
    );
  }

  void _exitApp(BuildContext context) async {
    await SystemNavigator.pop();
  }
}
