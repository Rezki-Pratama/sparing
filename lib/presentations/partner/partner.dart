
import 'package:flutter/material.dart';
import 'package:sparing/presentations/partner/partner_screen.dart';
import 'package:sparing/presentations/widget/drawer_screen.dart';

class Partner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          PartnerScreen()
        ],
      ),
    );
  }
}