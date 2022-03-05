import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:player/screens/widget/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';


class VidePlayerHome extends StatefulWidget {
  const VidePlayerHome({Key? key}) : super(key: key);

  @override
  _VidePlayerHomeState createState() => _VidePlayerHomeState();
}

class _VidePlayerHomeState extends State<VidePlayerHome> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });

    // _controller = VideoPlayerController.asset(
    //     'assets/av.mkv')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });

    _controller = VideoPlayerController.asset(
        'assets/av.mkv')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    // setLandScape();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Video Player"),
      // ),
      body: SafeArea(
        child: Center(
          child: _controller.value.isInitialized
              ? buildVideo()
              : Container(),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      onPressed: () async {
        // setState(() {
        //   // _controller.value.isPlaying
        //   //     ? _controller.pause()
        //   //     : _controller.play();
        // });

        final file = await filePicker();
        if (file == null) return;
        _controller = VideoPlayerController.file(file)..addListener(() => setState(() {}))..setLooping(true)..initialize().then((value) {
          _controller.play();
          setState(() {});
        });
      },
      child: const Icon(
        Icons.add
      ),
    );
  }

  Widget buildVideo() {

    return OrientationBuilder(
      builder: (context, orientation) {
        final isPotrait = orientation == Orientation.portrait;
        return Container(
          child: Stack(
            alignment: Alignment.center,
            fit: isPotrait? StackFit.loose : StackFit.passthrough,
            children: [
              buildAspectRatio(),
              BasicOverlayWidget(
                  controller: _controller,
                  onClickerFullScreen: () async {
                    await SystemChrome.setEnabledSystemUIOverlays([]);
                    if (isPotrait) {
                      AutoOrientation.landscapeRightMode();
                  }else {
                      AutoOrientation.portraitUpMode();
                    }
              }
              ),
            ],
          ),
        );
    });
  }

  AspectRatio buildAspectRatio() {
    return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      );
  }

  Widget buildFullScreen({required Widget child}) {
    final size = _controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(fit: BoxFit.cover,child: SizedBox(width: width, height: height, child: child,));
  }

  filePicker() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) {
      return null;
    }
    return File(result.files.single.path.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void setLandScape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }
}
