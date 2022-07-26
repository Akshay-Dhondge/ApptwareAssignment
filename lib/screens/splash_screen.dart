import 'dart:async';
import 'package:assignment/screens/list_view_page.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.bounceOut);

    _controller!.forward();

    startTime();
  }

  @override
  dispose() {
    _controller!.dispose();
    super.dispose();
  }

  startTime() async {
    var _duration = const Duration(milliseconds: 1500);
    return Timer(_duration, authenticate);
  }

  Future<void> authenticate() async {
    Navigator.of(context).pushReplacement(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      settings: const RouteSettings(),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ListViewPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 400,
              child: ScaleTransition(
                scale: _animation!,
                child: Center(
                  child: Image.asset(
                    'images/splash_logo.jpeg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
