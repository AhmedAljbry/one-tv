import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:onetv/Screen/comp.dart';
import 'package:onetv/s.dart';
import 'package:video_player/video_player.dart';

import 'Screen/HD/Fhd.dart';
import 'Screen/HD/low.dart';
import 'Screen/HD/sd.dart';


enum VideoQuality { low, sd, hd, fhd }

class MyCustomControls extends StatefulWidget {
  final VoidCallback onPlay;
  final VoidCallback replay;
  final VoidCallback seekForward;
  final VoidCallback full;
  final VoidCallback picuter;
  final VoidCallback cast;
  //final ChewieController? _chewieController;

  final bool isPlaying;
  final bool isfull;
  late final VideoPlayerController videoPlayerController;
  final Floating floating;
 final VideoQuality currentQuality;
/*  final String low;
  final String sd;
  final String hd;
  final String fhd;*/

  late bool controlsVisible;
  final List<String> videoLinks;

   MyCustomControls({
    Key? key,
    required this.onPlay,
    required this.full,
    required this.isPlaying,
    required this.replay,
    required this.seekForward,
    required this.videoPlayerController,
     required this.floating,
     required this.isfull,
     required this.picuter,
     required this.videoLinks, required this.currentQuality,
     required this.cast,


  }) : super(key: key);

  @override
  State<MyCustomControls> createState() => _MyCustomControlsState();
}

class _MyCustomControlsState extends State<MyCustomControls> with WidgetsBindingObserver {
  late bool isPlayingLocal;
  late bool isfullLocal;

  late Timer hideControlsTimer;
  late bool controlsVisible;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    isPlayingLocal = widget.isPlaying;
    isfullLocal = widget.isfull;
    controlsVisible = true;
    widget.videoPlayerController.addListener(_onVideoControllerUpdate);


    _startHideControlsTimer();
  }
  void _startHideControlsTimer() {
    hideControlsTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        controlsVisible = false;
      });
    });
  }

  void _resetHideControlsTimer() {
    hideControlsTimer.cancel();

    _startHideControlsTimer();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.videoPlayerController.removeListener(_onVideoControllerUpdate);
    hideControlsTimer.cancel();
    super.dispose();
  }

  void _onVideoControllerUpdate() {
    if (!widget.videoPlayerController.value.isPlaying)
    {
      setState(() {
        isPlayingLocal = false;
        _resetHideControlsTimer(); // Reset the timer when there's no playback
      });
    } else if (!isPlayingLocal) {
      setState(() {
        isPlayingLocal = true;
      });
    }
    // Update text and slider
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>a=

    [


      defauletButton(
        function: ()
        {
          navigatorfansh(context: context,widget: low(
            fhdurl: "http://maveniptv.tv:8080/ahmad34007/ahm3640072/64697",
            hdurl:"http://maveniptv.tv:8080/ahmad34007/ahm3640072/64696" ,
            sdurl: "http://maveniptv.tv:8080/ahmad34007/ahm3640072/64695",
            lowurl:"http://maveniptv.tv:8080/ahmad34007/ahm3640072/64694",
            dataSourceType: DataSourceType.network,
          ),);

        },
        text: "low",
        color:widget.currentQuality == VideoQuality.low ? Colors.blue : Colors.grey,width: 80.0,),
      defauletButton(
        function: ()
        {
          navigatorfansh(context: context,widget: sd(
            fhdurl: "http://maveniptv.tv:8080/ahmad34007/ahm3640072/64697",
            hdurl:"http://maveniptv.tv:8080/ahmad34007/ahm3640072/64696" ,
            sdurl: "http://maveniptv.tv:8080/ahmad34007/ahm3640072/64695",
            lowurl:"http://maveniptv.tv:8080/ahmad34007/ahm3640072/64694",
            dataSourceType: DataSourceType.network,
          ),);
        },
        text: "sd",
        color: widget.currentQuality == VideoQuality.sd ? Colors.blue : Colors.grey,width: 80.0,),
      defauletButton(
        function: ()
        {
          navigatorfansh(context: context,widget: VideoPlayerView(
            fhdurl: "http://maveniptv.tv:8080/ahmad34007/ahm3640072/64697",
            hdurl:"http://maveniptv.tv:8080/ahmad34007/ahm3640072/64696" ,
            sdurl: "http://maveniptv.tv:8080/ahmad34007/ahm3640072/64695",
            lowurl:"http://maveniptv.tv:8080/ahmad34007/ahm3640072/64694",
            dataSourceType: DataSourceType.network,
          ),);
        },
        text: "hd",
        color: widget.currentQuality == VideoQuality.hd ? Colors.blue : Colors.grey,width: 80.0,),
      defauletButton(
        function: ()
        {
          navigatorfansh(context: context,widget: fhd(
            fhdurl: "http://maveniptv.tv:8080/ahmad34007/ahm3640072/64697",
            hdurl:"http://maveniptv.tv:8080/ahmad34007/ahm3640072/64696" ,
            sdurl: "http://maveniptv.tv:8080/ahmad34007/ahm3640072/64695",
            lowurl:"http://maveniptv.tv:8080/ahmad34007/ahm3640072/64694",
            dataSourceType: DataSourceType.network,
          ),);
        },
        text: "fhd",
        color: widget.currentQuality == VideoQuality.fhd ? Colors.blue : Colors.grey,width: 80.0,),
    ];
    return widget.videoPlayerController.value.isBuffering?Center(child: CircularProgressIndicator()):GestureDetector(
      onTap: () {
        setState(() {
          controlsVisible = !controlsVisible;
          print('controlsVisible: $controlsVisible'); // إضافة هذا السطر للتحقق من قيمة controlsVisible
          if (controlsVisible) {
            _resetHideControlsTimer();
          }
        });
      },
      child: AnimatedOpacity(
        opacity: controlsVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.20),
          appBar: AppBar(
            leading:IconButton(onPressed: ()
            {
              widget.cast();
            }, icon: Icon(Icons.cast)) ,
            backgroundColor: Colors.black.withOpacity(0.20),
            actions:a,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    formatDuration(widget.videoPlayerController.value.position),
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final tapPosition = (widget.videoPlayerController.value.duration.inSeconds.toDouble() *
                            (widget.videoPlayerController.value.position.inSeconds / widget.videoPlayerController.value.duration.inSeconds));
                        final newPosition = Duration(seconds: tapPosition.toInt());
                        widget.videoPlayerController.seekTo(newPosition);
                      },
                      child: Slider(
                        max:widget.videoPlayerController.value.position.inSeconds.toDouble(),
                        min:widget.videoPlayerController.value.position.inSeconds.toDouble(),
                        value: widget.videoPlayerController.value.position.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            final newPosition = Duration(seconds: value.toInt());
                            widget.videoPlayerController.seekTo(newPosition);
                          });
                        },
                        thumbColor: Colors.redAccent,
                        activeColor: Colors.blue,  // لون الفترة التي تمر بها
                        inactiveColor: Colors.grey,
                        mouseCursor: MouseCursor.uncontrolled,


                        // لون الفترة التي لم يتم تشغيلها بعد
                        semanticFormatterCallback: (double value) {
                          return '${formatDuration(Duration(seconds: value.toInt()))}';
                        },
                      ),
                    ),
                  ),
                  Text(
                    formatDuration(widget.videoPlayerController.value.duration),
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.aspect_ratio),
                    onPressed: () {
                      // استدعاء changeFitMode عند الضغط على الزر

                    },
                  ),


                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.replay_10),
                    onPressed: () {
                      setState(() {
                        widget.replay();
                      });
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isPlayingLocal ? Icons.pause_circle_outline_outlined : Icons.play_circle_outline,
                    ),
                    onPressed: () {
                      setState(() {
                        isPlayingLocal = !isPlayingLocal;
                      });
                      widget.onPlay();
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.forward_10_rounded),
                    onPressed: () {
                      setState(() {
                        widget.seekForward();
                      });
                    },
                  ),
                  Spacer(),

        FutureBuilder<bool>(
        future: widget.floating.isPipAvailable,
        initialData: false,
        builder: (context, snapshot) => snapshot.data ?? false
        ? PiPSwitcher(
        childWhenDisabled: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.picture_in_picture_alt_outlined),
        onPressed: () {
        setState(() {
        widget.picuter();
        });

        },
        ),
        childWhenEnabled: const SizedBox(),
        )
            : const Card(
        child: Text('PiP unavailable'),
        ),
        ),

                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(isfullLocal?Icons.fullscreen_exit:Icons.fullscreen),
                    onPressed: () {
                      setState(() {
                        widget.full();
                      });
                    },
                  ),
                ]
              ),

            ],
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String _getVideoUrlForQuality(VideoQuality quality, List<String> videoLinks) {
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

}
