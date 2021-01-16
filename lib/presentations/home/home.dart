
import 'package:flutter/material.dart';
import 'package:sparing/presentations/home/home_screen.dart';
import 'package:sparing/presentations/home/drawer_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen()
        ],
      ),
    );
  }
}