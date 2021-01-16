import 'package:flutter/material.dart';
import 'package:sparing/utilities/utilities.dart';

class PartnerScreen extends StatefulWidget {
  @override
  _PartnerScreenState createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  final TextEditingController _searchController = TextEditingController();
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  List<BoxShadow> shadowList = [
    BoxShadow(
        color: Utilities.colorDarkerBlue, blurRadius: 10, offset: Offset(0, 5))
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Utilities.colorDarkerBlue,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: AnimatedContainer(
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
                    height: size.height / 1.5,
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
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.15)),
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
                                                            BorderRadius
                                                                .circular(
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
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          vertical: size.height * 0.01),
                      margin:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Utilities.colorDarkerBlue,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: shadowList),
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  if (_searchController.text.isNotEmpty) {
                                    print(_searchController.text);
                                  }
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                )),
                            border: InputBorder.none,
                            hintText: 'Find sparring partner',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
