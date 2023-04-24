import 'package:flutter/material.dart';
import 'package:parallax_effect/features/presentation/widgets/video_card.dart';

import 'pictures_card.dart';

class ParallaxBuilder extends StatefulWidget {
  const ParallaxBuilder({Key? key}) : super(key: key);

  @override
  State<ParallaxBuilder> createState() => _ParallaxBuilderState();
}

class _ParallaxBuilderState extends State<ParallaxBuilder> {
  late PageController _pageController;
  int _selectedIndex = 0;
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
  // final videos = [
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  // ];
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
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
            child: PageView.builder(
                pageSnapping: false,
                controller: _pageController,
                itemCount: pictures.length,
                onPageChanged: (value) {
                  // print('valuess = $value');
                  _selectedIndex = value;
                  print('_selectedIndex = $_selectedIndex');
                  setState(() {});
                },
                itemBuilder: (context, index) => PicturesCard(
                      assetPath: pictures[index],
                      isSelected: _selectedIndex == index,
                    )),
            // controller: _pageController,
            // itemCount: videos.length,
            // onPageChanged: (value) {
            //   print('valuess = $value');
            // },
            // itemBuilder: (context, index) =>
            //     VideoCard(assetPath: videos[index])),
          ),
        ],
      ),
    );
  }
}
