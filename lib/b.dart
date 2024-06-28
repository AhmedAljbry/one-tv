import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onetv/Screen/comp.dart';
import 'package:onetv/Screen/comp.dart';
import 'package:onetv/s.dart';
import 'package:uni_links3/uni_links.dart';
import 'package:video_player/video_player.dart';

import 'Screen/comp.dart';

class VideoPlayersScreen extends StatefulWidget {
  const VideoPlayersScreen({Key? key, this.lowurl,  this.sdurl,  this.hdurl,  this.fhdurl}) : super(key: key);
  final String? lowurl;
  final String? sdurl;
  final String? hdurl;
  final String? fhdurl;
  @override
  State<VideoPlayersScreen> createState() => _VideoPlayersScreenState();
}

class _VideoPlayersScreenState extends State<VideoPlayersScreen> {
  String _receivedLink = "No link received yet";
  late String urlv;

  @override
  void initState() {
    super.initState();
   urlv=widget!.lowurl!;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // قم بتحديث هذا الجزء لتضمين الـ SystemChrome
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // ثم يجب أن يكون لديك Scaffold داخل الدالة build
    return Scaffold(
      appBar: AppBar(
        title: Text('Video URL: ', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.redAccent,
      ),
      body: VideoPlayerView(
        fhdurl: widget.fhdurl!,
        hdurl: widget.hdurl!,
        sdurl: widget.sdurl!,
        lowurl: widget.lowurl!,
        dataSourceType: DataSourceType.network,
      ),
    );
  }
}
