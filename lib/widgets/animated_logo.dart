import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class AnimatedLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MirrorAnimation(
          builder: (BuildContext context, Widget child, value) {
            return Transform.translate(
              offset: Offset(0, value),
              child: child,
            );
          },
          tween: (0.0).tweenTo(-25.0),
          curve: Curves.easeInOut,
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            semanticsLabel: 'Journapi Logo',
            width: 150,
            height: 150,
          ),
        ),
        MirrorAnimation(
          tween: Colors.grey.shade700.tweenTo(Colors.grey.shade400),
          curve: Curves.easeInOut,
          builder: (BuildContext context, Widget child, color) {
            return MirrorAnimation(
              tween: (100.0).tweenTo(40.0),
              curve: Curves.easeInOut,
              builder: (BuildContext context, Widget child, width) {
                return Container(
                  width: width,
                  height: 16,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(99),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
