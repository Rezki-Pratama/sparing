
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor(
       "assets/flare/splash.flr", fit: BoxFit.cover, animation: "splash", 
      ),
    );
  }
}