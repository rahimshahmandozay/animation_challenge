import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:vector_math/vector_math_64.dart' show Vector3;

class DayThree extends StatefulWidget {
  const DayThree({super.key});

  @override
  State<DayThree> createState() => _DayThreeState();
}

class _DayThreeState extends State<DayThree> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  final widthAndHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..forward();
    _yController
      ..reset()
      ..forward();
    _zController
      ..reset()
      ..forward();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: widthAndHeight,
              width: double.infinity,
            ),
            AnimatedBuilder(
              animation: Listenable.merge(
                [_xController, _yController, _zController],
              ),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xController))
                    ..rotateY(_animation.evaluate(_yController))
                    ..rotateZ(_animation.evaluate(_zController)),
                  child: Stack(
                    children: [
                      // BACK
                      Container(
                        height: widthAndHeight,
                        width: widthAndHeight,
                        color: Colors.green,
                      ),
                      // FRONT
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(
                            Vector3(0, 0, -widthAndHeight),
                          ),
                        child: Container(
                          height: widthAndHeight,
                          width: widthAndHeight,
                          color: Colors.purple,
                        ),
                      ),
                      // LEFT
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..rotateY(
                            pi / 2.0,
                          ),
                        child: Container(
                          height: widthAndHeight,
                          width: widthAndHeight,
                          color: Colors.red,
                        ),
                      ),
                      // RIGHT
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..rotateY(
                            -pi / 2.0,
                          ),
                        child: Container(
                          height: widthAndHeight,
                          width: widthAndHeight,
                          color: Colors.orange,
                        ),
                      ),
                      // TOP
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()
                          ..rotateX(
                            -pi / 2.0,
                          ),
                        child: Container(
                          height: widthAndHeight,
                          width: widthAndHeight,
                          color: Colors.brown,
                        ),
                      ),
                      // BOTTOM
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..rotateX(
                            pi / 2.0,
                          ),
                        child: Container(
                          height: widthAndHeight,
                          width: widthAndHeight,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
