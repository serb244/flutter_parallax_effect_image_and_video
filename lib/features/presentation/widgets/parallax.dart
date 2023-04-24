import 'package:flutter/material.dart';

import 'parallax_vert.dart';

class Parallax extends StatefulWidget {
  const Parallax({Key? key}) : super(key: key);

  @override
  State<Parallax> createState() => _ParallaxState();
}

class _ParallaxState extends State<Parallax> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: const <Widget>[
          Center(
            child: Text('First Page'),
          ),
          Center(
            child: ParallaxVert(),
          ),
          Center(
            child: Text('Third Page'),
          ),
        ],
      ),
    );
  }
}
