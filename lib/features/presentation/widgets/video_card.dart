import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../core/utils/parallax_flow_delegate.dart';

class VideoCard extends StatefulWidget {
  final String assetPath;
  final bool isSelected;

  const VideoCard({
    super.key,
    required this.assetPath,
    required this.isSelected,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  final GlobalKey _videoKey = GlobalKey();
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset(widget.assetPath);
    _videoPlayerController
      ..addListener(() => setState(() {}))
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)
      ..setVolume(0)
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: widget.isSelected
          ? const EdgeInsets.symmetric(vertical: 8, horizontal: 4)
          : const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 6),
            blurRadius: 8,
          )
        ],
      ),
      child: _videoPlayerController.value.isInitialized
          ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Flow(
                delegate: ParallaxFlowDelegate(
                  scrollable: Scrollable.of(context),
                  listItemContext: context,
                  backgroundImageKey: _videoKey,
                ),
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: VideoPlayer(
                      _videoPlayerController,
                      key: _videoKey,
                    ),
                  )
                ],
              ),
            )
          : Container(),
    );
  }
}
