import 'package:flutter/material.dart';

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
      right: 100,
      // left: 70,
      bottom: 20,
      child: Opacity(
        opacity: 0.7,
        child: Container(
          color: Colors.black,
          child: Text(
            widget.assetPath,
            style: const TextStyle(color: Colors.white, fontSize: 26),
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

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxHeight,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.topCenter(Offset.zero),
        ancestor: scrollableBox);

    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dx / viewportDimension).clamp(0.0, 1.0);

    final horizontalAlignment = Alignment(scrollFraction * 2 - 1, 0.0);

    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect = horizontalAlignment.inscribe(
        backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(childRect.left, 0.0)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
