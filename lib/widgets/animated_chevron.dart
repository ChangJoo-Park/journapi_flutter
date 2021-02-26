import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnimatedChevron extends StatefulWidget {
  final AnimationController controller;
  final bool isInitialForwarded;
  AnimatedChevron({Key key, this.controller, this.isInitialForwarded})
      : super(key: key);
  @override
  _AnimatedChevronState createState() => _AnimatedChevronState();
}

class _AnimatedChevronState extends State<AnimatedChevron>
    with TickerProviderStateMixin {
  Animation _arrowAnimation;
  AnimationController _arrowAnimationController;

  @override
  void initState() {
    _arrowAnimationController = widget.controller;

    _arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);
    if (widget.isInitialForwarded) {
      _arrowAnimationController.forward();
    }

    super.initState();
  }

  @override
  void dispose() {
    _arrowAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _arrowAnimationController,
      builder: (context, child) => Transform.rotate(
        angle: _arrowAnimation.value,
        child: SvgPicture.asset(
          'assets/images/chevron.svg',
          width: 16,
          height: 16,
        ),
      ),
    );
  }
}
