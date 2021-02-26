import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class Collapsible extends StatefulWidget {
  final String title;
  final Widget child;
  final bool hasChildBorder;
  Collapsible({
    Key key,
    @required this.title,
    @required this.child,
    this.hasChildBorder = false,
  }) : super(key: key);
  @override
  _CollapsibleState createState() => _CollapsibleState();
}

class _CollapsibleState extends State<Collapsible> {
  bool isOpened = false;
  bool isInitialized = true;
  @override
  void initState() {
    isInitialized = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() => isOpened = !isOpened);
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
                          horizontal: 16.0, vertical: 8.0),
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
                    icon: Icon(
                      isOpened
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_up_rounded,
                      color: Colors.white,
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
