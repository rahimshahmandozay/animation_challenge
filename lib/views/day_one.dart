import 'package:flutter/material.dart';
import 'dart:math' show pi;

class DayOne extends StatefulWidget {
  const DayOne({super.key});

  @override
  State<DayOne> createState() => _DayOneState();
}

class _DayOneState extends State<DayOne> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: pi * 2,
    ).animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateY(
                      _animation.value,
                    ),
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: const BoxDecoration(color: Colors.blue),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
