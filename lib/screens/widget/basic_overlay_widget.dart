import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onClickerFullScreen;

  const BasicOverlayWidget({Key? key, required this.controller, required this.onClickerFullScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        controller.value.isPlaying? controller.pause() : controller.play();
      },
      // onHorizontalDragStart: (DragStartDetails details) {
      //   print("start");
      //   controller.seekTo(Duration.zero);
      // },
      // onHorizontalDragEnd: (DragEndDetails details) {
      //   print("end");
      // },
      // onHorizontalDragEnd: () {
      //   controller.
      // },
      child: Stack(
        children: [
          // buildPlay(),
          Positioned(
            child: Row(
              children: [
                Expanded(
                  child: buildIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 28, top: 0, bottom: 0),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.fullscreen,
                    ),
                    onTap: onClickerFullScreen,
                  ),
                )
              ],
            ),
            bottom: 0,
            left: 0,
            right: 0,),
        ],
      ),
    );
  }

  buildIndicator() {
    return VideoProgressIndicator(
        controller,
        allowScrubbing: true,
    );
  }

  // buildPlay() {
  //   print("plsy osd");
  //   return controller.value.isPlaying?
  //   Container() :
  //   Container(alignment: Alignment.center, color: Colors.black26,
  //       child: const Icon(Icons.play_arrow, color: Colors.white, size: 80,));
  // }
  Future<void> setLandScape() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

}
