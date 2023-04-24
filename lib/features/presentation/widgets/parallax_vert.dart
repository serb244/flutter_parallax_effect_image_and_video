import 'package:flutter/material.dart';

class ParallaxVert extends StatefulWidget {
  const ParallaxVert({Key? key}) : super(key: key);

  @override
  State<ParallaxVert> createState() => _ParallaxVertState();
}

class _ParallaxVertState extends State<ParallaxVert> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,

        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: const <Widget>[
          Center(
            child: Text('First ParallaxVert'),
          ),
          Center(
            child: Text('Second ParallaxVert'),
          ),
          Center(
            child: Text('Third ParallaxVert'),
          ),
        ],
      ),
    );
  }
}
