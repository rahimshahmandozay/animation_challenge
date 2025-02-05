import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);

    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

Color getRandomColor() => Color(
      0x00000000 + math.Random().nextInt(0xFFFFFFFF),
    );

class DaySix extends StatefulWidget {
  const DaySix({super.key});

  @override
  State<DaySix> createState() => _DaySixState();
}

class _DaySixState extends State<DaySix> {
  var _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: CircleClipper(),
          child: TweenAnimationBuilder(
            tween: ColorTween(
              begin: getRandomColor(),
              end: _color,
            ),
            onEnd: () {
              setState(() {
                _color = getRandomColor();
              });
            },
            duration: const Duration(
              seconds: 1,
            ),
            child: Container(
              height: size.width,
              width: size.width,
              color: Colors.red,
            ),
            builder: (context, Color? color, child) {
              "Color: $color".log();
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  color!,
                  BlendMode.srcATop,
                ),
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
