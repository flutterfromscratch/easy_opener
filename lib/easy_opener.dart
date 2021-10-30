library easy_opener;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EasyOpener extends StatefulWidget {
  final Widget child;
  final VoidCallback onComplete;
  final Color backgroundColor;
  final Curve? animationCurve;
  final Color? boxBackgroundColor;
  final BuildContext context;

  const EasyOpener({
    Key? key,
    required this.child,
    required this.onComplete,
    required this.backgroundColor,
    required this.context,
    this.animationCurve = Curves.bounceOut,
    this.boxBackgroundColor = Colors.white,
  }) : super(key: key);

  @override
  _EasyOpenerState createState() => _EasyOpenerState();
}

class _EasyOpenerState extends State<EasyOpener> {
  bool expanded = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      setState(() {
        expanded = true;
      });

      Future.delayed(Duration(seconds: 3)).then((value) {
        widget.onComplete();
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: widget.backgroundColor,
          child: Center(
            child: AnimatedContainer(
              curve: widget.animationCurve ?? Curves.bounceOut,
              duration: Duration(
                seconds: 1,
                milliseconds: 500,
              ),
              height: expanded ? MediaQuery.of(context).size.width * 0.7 : 100,
              width: expanded ? MediaQuery.of(context).size.width * 0.7 : 100,
              child: FittedBox(
                child: widget.child,
                fit: BoxFit.contain,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  // shape: RoundedRectangleBorder(),
                  // border: RoundedRectangleBorder(),
                  borderRadius: BorderRadius.circular(expanded ? 12 : 24),
                  boxShadow: expanded
                      ? [
                          BoxShadow(
                            blurRadius: 30,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(10, 10),
                          ),
                        ]
                      : null),
            ),
          ),
        ),
        Align(
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: expanded ? 1.0 : 0.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(
                color: Colors.white.withOpacity(0.4),
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}
