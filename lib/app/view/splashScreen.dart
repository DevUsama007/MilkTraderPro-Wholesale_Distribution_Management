import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khata_app/app/view/home_screen_view.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(
      Duration(seconds: 2),
      (timer) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreenView(),
            ));
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/appicon.png',
              width: 100,
              height: 100,
            ),
            Text(
              'Alkhar Milk Point',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
