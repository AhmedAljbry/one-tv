import 'dart:async';
import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onetv/cusetem.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:video_player/video_player.dart';


class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    Key? key,


    required this.dataSourceType,
    required this.lowurl,
    required this.sdurl,
    required this.hdurl,
    required this.fhdurl,
  }) : super(key: key);

  final String lowurl;
  final String sdurl;
  final String hdurl;
  final String fhdurl;

  final DataSourceType dataSourceType;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();

}

class _VideoPlayerViewState extends State<VideoPlayerView> with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool isPlaying = true;
  bool isfull = true;
  late IconData iconToDisplay;
  late IconData iconfull;
  final floating = Floating();
  late VideoQuality currentQuality;
  late List<String> videoLinks =
  [
    widget.lowurl,
    widget.sdurl,
    widget.hdurl,
    widget.fhdurl
  ];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.lowurl);
        break;
      case DataSourceType.network:
        _videoPlayerController = VideoPlayerController.network(videoLinks[3]);
        break;
      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(widget.lowurl));
        break;
      case DataSourceType.file:
      // TODO: Handle this case.
        break;
    }
    currentQuality = VideoQuality.hd;
    _playVideosWithLinks();
    _videoPlayerController.initialize().then((_) {
      isPlaying = _videoPlayerController.value.isPlaying;
      iconToDisplay = isPlaying
          ? Icons.pause_circle_outline_outlined
          : Icons.play_circle_outline_rounded;

      setState(() {
        _chewieController = ChewieController(

            videoPlayerController: _videoPlayerController,
            aspectRatio: 16 / 9,
            autoPlay: true,
            autoInitialize: true,
            allowFullScreen: true,
            fullScreenByDefault: true,
            hideControlsTimer: Duration(seconds: 5),
            transformationController: TransformationController(),
            placeholder: Center(child: CircularProgressIndicator()),
            systemOverlaysOnEnterFullScreen: [
              SystemUiOverlay.bottom,
              SystemUiOverlay.top,
            ],

            systemOverlaysAfterFullScreen: [
              SystemUiOverlay.bottom,
              SystemUiOverlay.top,
            ],
            progressIndicatorDelay: Duration(seconds: 5),
            playbackSpeeds: [0.5, 1, 1.5, 2.0],
            optionsTranslation: OptionsTranslation(
              playbackSpeedButtonText: "aaaa",
              cancelButtonText: "ddddd",
            ),
            allowedScreenSleep: true,
           // fullScreenByDefault: true,
            controlsSafeAreaMinimum: EdgeInsets.all(20.0),
            deviceOrientationsOnEnterFullScreen: [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ],
            deviceOrientationsAfterFullScreen: [
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ],
            allowPlaybackSpeedChanging: true,
            draggableProgressBar: true,
            zoomAndPan: true,
            useRootNavigator: true,
            customControls: MyCustomControls(
              onPlay: () {
                setState(() {
                  isPlaying = !isPlaying;
                  if (!isPlaying) {
                    _videoPlayerController.play();
                    iconToDisplay = Icons.pause_circle_outline_outlined;
                  } else {
                    _videoPlayerController.pause();
                    iconToDisplay = Icons.play_circle_outline_rounded;
                  }
                });
              },
              full: ()
              {
                setState(() {
                  isfull = !isfull;
                  if (!isfull) {
                    _chewieController.exitFullScreen();
                    iconToDisplay = Icons.fullscreen_exit;
                  } else {
                    _chewieController.enterFullScreen();
                    iconToDisplay = Icons.fullscreen;
                  }
                });

              },
              isPlaying: isPlaying,
              replay: () {
                setState(() {
                  _seekVideo(-10);
                });
              },
              seekForward: () {
                setState(() {
                  _seekVideo(10);
                });
              },
              floating: floating,
              videoPlayerController: _videoPlayerController,
              isfull: isfull,
              picuter: ()
              {
                enablePip(context);
                _chewieController.showControls;
              },
              videoLinks: videoLinks,
              currentQuality: currentQuality, cast: ()
            {

              _launchWebVideoCaster();
            },



            )
        );
      });
      isfull=_chewieController.isFullScreen;
      isfull
          ? Icons.fullscreen_exit
          : Icons.fullscreen;

    });


  }
  Future<void> enablePip(BuildContext context) async {
    final rational = Rational.landscape();
    final screenSize =
        MediaQuery.of(context).size * MediaQuery.of(context).devicePixelRatio;
    final height = screenSize.width ~/ rational.aspectRatio;

    final status = await floating.enable(
      aspectRatio: rational,
      sourceRectHint: Rectangle<int>(
        0,
        (screenSize.height ~/ 2) - (height ~/ 2),
        screenSize.width.toInt(),
        height,
      ),
    );
    debugPrint('PiP enabled? $status');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    if (lifecycleState == AppLifecycleState.inactive) {
      floating.enable(aspectRatio: Rational.square());
    }
  }
  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
        condition: _videoPlayerController.value.isInitialized,
        builder: (context) => PiPSwitcher(
            childWhenDisabled:
            AspectRatio(
              aspectRatio: 9/16,
              child: Chewie(controller: _chewieController,

              ),
            ),

            childWhenEnabled: AspectRatio(
              aspectRatio: 9/16,
              child: Chewie(
                  controller: _chewieController,
              ),
            )

        ),
        fallback: (context) =>Center(child: CircularProgressIndicator())) ;
  }


  void _seekVideo(int seconds) {
    final currentPosition = _videoPlayerController.value.position;
    final newPosition = currentPosition + Duration(seconds: seconds);
    _videoPlayerController.seekTo(newPosition);
  }


  void _playVideosWithLinks() {



    // اختار الصيغة المطلوبة بناءً على الحالة الحالية
    final selectedQualityUrl = _getVideoUrlForQuality(currentQuality, videoLinks);

    // قم بتحديث مشغل الفيديو بالرابط المناسب
    _videoPlayerController = VideoPlayerController.network(selectedQualityUrl);

    // ... (قد تحتاج إلى إجراء أي تحديثات أخرى)
  }

  String _getVideoUrlForQuality(VideoQuality quality, List<String> videoLinks)
  {
    switch (quality) {

      case VideoQuality.low:
        return videoLinks[0];

      case VideoQuality.sd:
        return videoLinks[1];

      case VideoQuality.hd:
        return videoLinks[2];

      case VideoQuality.fhd:
        return videoLinks[3];
      default:
        return videoLinks[0]; // يمكنك تحديد رابط افتراضي هنا في حالة عدم توفر صيغة
    }
  }

  void _launchWebVideoCaster() async {
    final String secureUriParam = "secure_uri=true";
    final String encodedSecureUriParam = Uri.decodeComponent(secureUriParam);
    final String webVideoCasterURL =
        'wvc-x-callback://open?url=${Uri.decodeComponent(_chewieController.videoPlayerController.dataSource)}&${encodedSecureUriParam}';

    try {
      // Try to launch Web Video Caster using the custom URL scheme
      await launch(webVideoCasterURL);
    } catch (e) {
      // Handle the exception (e.g., the app is not installed)
      // Open Play Store if it fails to launch the app because the package doesn't exist.
      // Alternatively, you could use PackageManager.getLaunchIntentForPackage() and check for null.
      // You could try catch this and launch the Play Store website if it fails,
      // but this shouldn’t fail unless the Play Store is missing.
      final String playStoreURL =
          'market://details?id=com.instantbits.cast.webvideo';
      await launch(playStoreURL);
    }
  }
}

