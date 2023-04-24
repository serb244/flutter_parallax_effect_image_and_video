import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final String assetPath;

  const VideoCard({
    super.key,
    required this.assetPath,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _videoPlayerController;
  // @override
  // void initState() {
  //   _videoPlayerController = VideoPlayerController.network(widget.assetPath);
  //   _videoPlayerController
  //     ..addListener(() => setState(() {}))
  //     ..setLooping(true)
  //     ..setVolume(0)
  //     ..initialize().then((value) => setState(() {}))
  //     ..play();
  //   super.initState();
  // }
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset(widget.assetPath);
    _videoPlayerController
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((value) => setState(() {}))
      ..play();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 6),
                blurRadius: 8)
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController),
        ),
      ),
    );
  }
}
