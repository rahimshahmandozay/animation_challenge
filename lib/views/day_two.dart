import 'package:flutter/material.dart';
import 'dart:math' show pi;

enum CircleSide {
  left,
  right,
}

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(
        size.width / 2,
        size.height / 2,
      ),
      clockwise: clockwise,
    );
    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide circleSide;

  const HalfCircleClipper({
    required this.circleSide,
  });

  @override
  Path getClip(Size size) => circleSide.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class DayTwo extends StatefulWidget {
  const DayTwo({super.key});

  @override
  State<DayTwo> createState() => _DayTwoState();
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(
        duration,
        this,
      );
}

class _DayTwoState extends State<DayTwo> with TickerProviderStateMixin {
  late AnimationController _counterClockwiseRotationController;
  late Animation<double> _counterClockwiseRotationAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _counterClockwiseRotationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _counterClockwiseRotationAnimation = Tween<double>(
      begin: 0,
      end: -(pi / 2),
    ).animate(
      CurvedAnimation(
        parent: _counterClockwiseRotationController,
        curve: Curves.bounceOut,
      ),
    );
    // FLIP
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.bounceOut,
      ),
    );

    // STATUS LISTENERS
    _counterClockwiseRotationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _flipAnimation = Tween<double>(
                  begin: _flipAnimation.value, end: _flipAnimation.value + pi)
              .animate(
            CurvedAnimation(
              parent: _flipController,
              curve: Curves.bounceOut,
            ),
          );

          _flipController
            ..reset()
            ..forward();
        }
      },
    );

    _flipController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _counterClockwiseRotationAnimation = Tween<double>(
            begin: _counterClockwiseRotationAnimation.value,
            end: _counterClockwiseRotationAnimation.value + -(pi / 2),
          ).animate(
            CurvedAnimation(
              parent: _counterClockwiseRotationController,
              curve: Curves.bounceOut,
            ),
          );
          _counterClockwiseRotationController
            ..reset()
            ..forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _counterClockwiseRotationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterClockwiseRotationController
      ..reset()
      ..forward.delayed(
        const Duration(seconds: 1),
      );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _counterClockwiseRotationController,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ(
                  _counterClockwiseRotationAnimation.value,
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..rotateY(
                            _flipAnimation.value,
                          ),
                        child: ClipPath(
                          clipper: const HalfCircleClipper(
                            circleSide: CircleSide.left,
                          ),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(180),
                                bottomLeft: Radius.circular(180),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..rotateY(
                            _flipAnimation.value,
                          ),
                        child: ClipPath(
                          clipper: const HalfCircleClipper(
                            circleSide: CircleSide.right,
                          ),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
