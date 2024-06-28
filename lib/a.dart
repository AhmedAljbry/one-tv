/*



import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:pod_player/pod_player.dart';
import 'package:flutter/material.dart';



class PlayVideoFromNetwork extends StatefulWidget {
  const PlayVideoFromNetwork({Key? key, required this.link, required this.title}) : super(key: key);
  final String link;
  final String title;
  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {
  late final PodPlayerController controller;



  @override
  void initState() {

    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(

        widget.link,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true,mixWithOthers: true,),

      ),

        podPlayerConfig:  const PodPlayerConfig(
            autoPlay: true,
            isLooping: true,
            videoQualityPriority: [720, 360],
          forcedVideoFocus: true,
          wakelockEnabled: true,

        ),


    )..initialise();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("SIZE: ${MediaQuery.of(context).size.width}");
    return Scaffold(
      backgroundColor: Colors.black,
      body: OrientationBuilder(
        builder: (context, orientation) {
          // قم بتحديد التوجيه الذي تريده هنا
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);

          return Stack(

            children: [
              PodVideoPlayer(
                controller: controller,
                backgroundColor: Colors.black,
                alwaysShowProgressBar: true,
                podProgressBarConfig: PodProgressBarConfig(backgroundColor: Colors.black),
                videoTitle: Row(
                  children: [
                    IconButton(onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back_ios_sharp, color: Colors.white,)),
                    Expanded(
                      child: Text(
                        widget.title,
                        maxLines: 1,
                        style: Get.textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),

                      ),
                    ),
                  ],
                ),
                overlayBuilder: (options) {
                  return Container(
                    color: Colors.black.withOpacity(0.40),
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       AppBar(backgroundColor: Colors.black.withOpacity(0.40),)
                      ],
                    ),
                  );
                },


                matchFrameAspectRatioToVideo: true,
                matchVideoAspectRatioToFrame: true,

                onLoading: (context) =>

                const Center(child: CircularProgressIndicator(),),
              ),
            ],
          );
        }  ),

    );
  }
  void _onToggleFullScreen(isFullScreen) {
    isFullScreen!=controller.isFullScreen;
  }
}
*/
