import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journapi/widgets/animated_chevron.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class Collapsible extends StatefulWidget {
  final String title;
  final Widget child;
  final bool hasChildBorder;
  final bool openInitialized;

  Collapsible({
    Key key,
    @required this.title,
    @required this.child,
    this.openInitialized = false,
    this.hasChildBorder = false,
  }) : super(key: key);
  @override
  _CollapsibleState createState() => _CollapsibleState();
}

class _CollapsibleState extends State<Collapsible>
    with TickerProviderStateMixin {
  bool isOpened = false;
  bool isInitialized = true;
  AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    isOpened = widget.openInitialized;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (animationController.isAnimating) {
                return;
              }
              setState(() => isOpened = !isOpened);
              animationController.isCompleted
                  ? animationController.reverse()
                  : animationController.forward();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: (isOpened && widget.hasChildBorder)
                    ? BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      )
                    : BorderRadius.circular(7),
                color: Color(0xff7f9cf5),
              ),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontFamily: 'JetBrainsMono',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    splashRadius: 0.1,
                    icon: AnimatedChevron(
                      controller: animationController,
                      isInitialForwarded: isOpened,
                    ),
                    onPressed: () {
                      setState(() => isOpened = !isOpened);
                    },
                  )
                ],
              ),
            ),
          ),
          // child
          if (isOpened)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
                border: widget.hasChildBorder
                    ? Border.all(color: Color(0xff7f9cf5), width: 4)
                    : null,
              ),
              child: widget.child,
            ),
        ],
      ),
    );
  }
}
