import 'package:animation_challenge/models/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayFive extends StatelessWidget {
  const DayFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("People Information"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserDetails(
                    user: user,
                  ),
                ),
              );
            },
            leading: Hero(
              tag: user.name,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  user.picture,
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            title: Text(
              user.name,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text("${user.age} years old"),
            trailing: Icon(CupertinoIcons.forward),
          );
        },
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.user,
  });
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Hero(
          tag: user.name,
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).chain(
                        CurveTween(curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    child: toHeroContext.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: fromHeroContext.widget,
                );
            }
          },
          child: Text(
            user.picture,
            style: TextStyle(fontSize: 50),
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Name: ${user.name}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "Age: ${user.age} years old",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "Email: ${user.email}",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
