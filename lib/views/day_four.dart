import 'package:animation_challenge/models/headphones.dart';
import 'package:flutter/material.dart';

class DayFour extends StatefulWidget {
  const DayFour({super.key});

  @override
  State<DayFour> createState() => _DayFourState();
}

class _DayFourState extends State<DayFour> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 0.03),
    ).animate(
      _animationController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            SlideTransition(
              position: _animation,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 1000),
                child: Image.asset(
                    key: ValueKey<int>(_selectedIndex),
                    product[_selectedIndex].image),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Boat Rockerz 450R",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Blouetooth Headphones",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                product.length,
                (index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: product[index].color,
                          border: Border.all(
                            width: 2,
                            color: _selectedIndex == index
                                ? Colors.black54
                                : Colors.transparent,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: _selectedIndex == index
                              ? Colors.white
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            Text(
              "1999 AFN",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
