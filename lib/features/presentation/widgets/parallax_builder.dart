import 'package:flutter/material.dart';
import 'package:parallax_effect/features/presentation/widgets/video_card.dart';

import 'pictures_card.dart';

class ParallaxBuilder extends StatefulWidget {
  const ParallaxBuilder({Key? key}) : super(key: key);

  @override
  State<ParallaxBuilder> createState() => _ParallaxBuilderState();
}

class _ParallaxBuilderState extends State<ParallaxBuilder> {
  late PageController _imagePageController;
  late PageController _videoPageController;
  late PageController _mainPageController;
  int _pictureSelectedIndex = 0;
  int _videoSelectedIndex = 0;
  final videos = [
    'assets/videos/1.mp4',
    'assets/videos/2.mp4',
    'assets/videos/3.mp4',
    'assets/videos/4.mp4',
    'assets/videos/5.mp4'
  ];
  final pictures = [
    'assets/pictures/1.jpg',
    'assets/pictures/2.jpg',
    'assets/pictures/3.jpg',
    'assets/pictures/4.jpg',
    'assets/pictures/5.jpg'
  ];

  // final videosNetwork = [
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  // ];
  @override
  void initState() {
    _imagePageController = PageController(viewportFraction: 0.8);
    _videoPageController = PageController(viewportFraction: 0.8);
    _mainPageController = PageController(viewportFraction: 0.8);
    super.initState();
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _videoPageController.dispose();
    _mainPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: _mainPageController,
              children: [_picturePageView(), _videoPageView()],
            ),
          ),
        ],
      ),
    );
  }

  PageView _videoPageView() {
    return PageView.builder(
        // pageSnapping: false,
        controller: _videoPageController,
        itemCount: videos.length,
        onPageChanged: (value) {
          _videoSelectedIndex = value;
          setState(() {});
        },
        itemBuilder: (context, index) => VideoCard(
              assetPath: videos[index],
              isSelected: _videoSelectedIndex == index,
            ));
  }

  PageView _picturePageView() {
    return PageView.builder(
        pageSnapping: false,
        controller: _imagePageController,
        itemCount: pictures.length,
        onPageChanged: (value) {
          _pictureSelectedIndex = value;
          setState(() {});
        },
        itemBuilder: (context, index) => PictureCard(
              assetPath: pictures[index],
              isSelected: _pictureSelectedIndex == index,
            ));
  }
}
