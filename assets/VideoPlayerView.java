
import 'dart:io';


import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stv/cusetem.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    super.key,
    required this.url,
    required this.dataSourceType,
  });

  final String url;


  final DataSourceType dataSourceType;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _videoPlayerController;

  late ChewieController _chewieController;
  bool isplayng=true;
  late IconData iconisplaye;

  @override
  void initState() {
    super.initState();

    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.url);
        break;
      case DataSourceType.network:
        _videoPlayerController = VideoPlayerController.network(widget.url);
        break;
      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(widget.url));
        break;
      case DataSourceType.file:
        // TODO: Handle this case.
    }

    _videoPlayerController.initialize().then(
          (_) => setState(
            () => _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          autoInitialize: true,
          allowFullScreen: true,
          aspectRatio: 16/9,
          transformationController:TransformationController() ,
          placeholder:Center(child: CircularProgressIndicator()) ,
          systemOverlaysOnEnterFullScreen:
          [
            SystemUiOverlay.bottom,  // إخفاء أزرار التنقل في أسفل الشاشة
            SystemUiOverlay.top,
          ] ,
              systemOverlaysAfterFullScreen: [
                SystemUiOverlay.bottom,  // عرض أزرار التنقل في أسفل الشاشة بعد الخروج من وضع ملء الشاشة
                SystemUiOverlay.top,     // عرض شريط الحالة في أعلى الشاشة بعد الخروج من وضع ملء الشاشة
              ],
              progressIndicatorDelay: Duration(seconds: 5),
                playbackSpeeds: [0.5, 1, 1.5, 2.0],
              optionsTranslation: OptionsTranslation(
                playbackSpeedButtonText: "aaaa",
                cancelButtonText: "ddddd",
              ),
              allowedScreenSleep:true,
              fullScreenByDefault:true,
              controlsSafeAreaMinimum: EdgeInsets.all(20.0), // تحديد الحد الأدنى للمساحة الآمنة
              deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
              deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
               allowPlaybackSpeedChanging: true,
                draggableProgressBar:true,
                zoomAndPan:true,
                useRootNavigator: true,
               customControls:MyCustomControls(onPlay: ()
               {
                 setState(() {
                   isplayng= !isplayng;
                   if(!isplayng)
                   {
                     _videoPlayerController.play();
                      iconisplaye=Icons.pause_circle_outline_outlined;
                   }
                   else
                   {
                     _videoPlayerController.pause();
                     iconisplaye=Icons.play_circle_outline_rounded;
                   }
                 });



               },
               full: () {

               },
                isplaye: isplayng,
                 replay:()
                 {
                  setState(() {
                    _seekVideo(-10);

                  });
                 },
                 seekForward: ()
                 {
                  setState(() {
                    _seekVideo(10);
                  });
                 },

               ),

               // overlay: Icon(Icons.add,color: Colors.amber,size: 200),
             // customControls: MyCustomControls(),

              // تحديد الحد الأدنى للمساحة الآمنة




            ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.dataSourceType.name.toUpperCase(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(
              controller: _chewieController,

          ),
        ),
      ],
    );
  }
  void _seekVideo(int seconds) {
    final currentPosition = _videoPlayerController.value.position;
    final newPosition = currentPosition + Duration(seconds: seconds);
    _videoPlayerController.seekTo(newPosition);
  }
}