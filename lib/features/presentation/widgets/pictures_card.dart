import 'package:flutter/material.dart';

import '../../../core/utils/parallax_flow_delegate.dart';

class PictureCard extends StatefulWidget {
  final String assetPath;
  final bool isSelected;

  const PictureCard({
    super.key,
    required this.assetPath,
    required this.isSelected,
  });

  @override
  State<PictureCard> createState() => _PictureCardState();
}

class _PictureCardState extends State<PictureCard> {
  final GlobalKey _stackKey = GlobalKey();

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
              blurRadius: 8)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Flow(
          delegate: ParallaxFlowDelegate(
            scrollable: Scrollable.of(context),
            listItemContext: context,
            backgroundImageKey: _stackKey,
          ),
          children: [
            AspectRatio(
              aspectRatio: 3 / 3,
              child: Stack(
                fit: StackFit.expand,
                key: _stackKey,
                children: <Widget>[
                  buildImage(),
                  buildPositionedText(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPositionedText() {
    return Positioned(
      left: 100,
      bottom: 20,
      child: Opacity(
        opacity: 0.7,
        child: Container(
          color: Colors.black,
          child: Text(
            widget.assetPath,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Image buildImage() {
    return Image.asset(
      widget.assetPath,
      fit: BoxFit.fitHeight,
    );
  }
}
