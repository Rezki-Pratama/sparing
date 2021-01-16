import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparing/presentations/partner/partner.dart';
import 'package:sparing/utilities/utilities.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  List<BoxShadow> shadowList = [
    BoxShadow(
        color: Utilities.colorDarkerBlue, blurRadius: 10, offset: Offset(0, 5))
  ];

  List<BoxShadow> shadowList2 = [
    BoxShadow(
        color: Utilities.colorMediumBlue, blurRadius: 10, offset: Offset(0, 5))
  ];

  Color primaryGreen = Color(0xff416d6d);

  List<Map> categories = [
    {'name': 'Cats', 'iconPath': 'assets/images/google.png'},
    {'name': 'Dogs', 'iconPath': 'assets/images/google.png'},
    {'name': 'Bunnies', 'iconPath': 'assets/images/google.png'},
    {'name': 'Parrots', 'iconPath': 'assets/images/google.png'},
    {'name': 'Horses', 'iconPath': 'assets/images/google.png'}
  ];

  static List randomImage = [
    'assets/images/illustration_football.png',
    'assets/images/illustration_basket.png',
  ];

  static var _random = Random();
  var imageToShow = randomImage[_random.nextInt(randomImage.length)];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      height: size.height,
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius:
              BorderRadius.circular(isDrawerOpen ? size.width * 0.15 : 0.0)),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  height: size.height / 3.5,
                  decoration: BoxDecoration(
                    borderRadius: isDrawerOpen
                        ? BorderRadius.circular(size.width * 0.15)
                        : BorderRadius.only(
                            topLeft: Radius.circular(size.width * 0.15),
                            topRight: Radius.circular(size.width * 0.15)),
                    color: Utilities.colorDarkerBlue,
                  ),
                ),
              ),
            ),
            Container(
              height: size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * 0.15)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              if (isDrawerOpen) {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              } else {
                                setState(() {
                                  xOffset = size.width * 0.70;
                                  yOffset = size.height * 0.20;
                                  scaleFactor = 0.6;
                                  isDrawerOpen = true;
                                });
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              width: size.width * 0.20,
                              height: size.height * 0.07,
                              child: Center(
                                  child: !isDrawerOpen
                                      ? Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: size.width * 0.06),
                                                child: Icon(Icons.menu),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width * 0.06),
                                                child: Container(
                                                  height: size.height * 0.06,
                                                  width: size.width * 0.11,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              size.height *
                                                                  0.20)),
                                                  child: Image.asset(
                                                      'assets/images/google.png'),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Icon(
                                          Icons.arrow_back_ios,
                                          size: 40,
                                        )),
                            )),
                        Container(
                          width: size.width * 0.25,
                          child: Image.asset('assets/images/logo.png'),
                        )
                      ],
                    ),
                  ),
                  Container(
                      width: size.width / 1.5,
                      child: Image.asset(
                          imageToShow.toString())),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.01),
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Utilities.colorDarkerBlue,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: shadowList),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: (){
                            if(_searchController.text.isNotEmpty){
                            print(_searchController.text);
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Partner()));
                          
                            }
                          },
                          child: Icon(Icons.search, color: Colors.white,)),
                        border: InputBorder.none,
                        hintText: 'Find sparring partner',
                        hintStyle: TextStyle(color: Colors.white)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Utilities.colorMediumBlue,
                            boxShadow: shadowList2,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(size.width * 0.15),
                                bottomLeft: Radius.circular(size.width * 0.15)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(size.height * 0.02),
                            child: Text('Interested Team',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.030)),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            color: Utilities.colorMediumBlue,
                            boxShadow: shadowList2,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(size.width * 0.15),
                                bottomLeft: Radius.circular(size.width * 0.15)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(size.height * 0.02),
                            child: Text('Interested Player',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.030)),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Utilities.colorMediumBlue,
                                boxShadow: shadowList2,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(size.width * 0.15),
                                    bottomLeft:
                                        Radius.circular(size.width * 0.15)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(size.height * 0.02),
                                child: Text('Competition',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height * 0.030)),
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Container(
                              decoration: BoxDecoration(
                                  color: Utilities.colorMediumBlue,
                                  boxShadow: shadowList2),
                              child: Padding(
                                padding: EdgeInsets.all(size.height * 0.02),
                                child: Text('Agent',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height * 0.030)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
