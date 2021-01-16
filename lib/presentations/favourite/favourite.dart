import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparing/models/sport.dart';
import 'package:sparing/presentations/auth/bloc/auth_bloc.dart';
import 'package:sparing/services/sport_service.dart';
import 'package:sparing/services/user_service.dart';
import 'package:sparing/utilities/utilities.dart';

import 'bloc/favourite_bloc.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  FavouriteBloc _favouriteBloc;
  SportServices _sportServices = SportServices();
  UserServices _userServices = UserServices();
  String isSport;

  @override
  void initState() {
    _favouriteBloc = FavouriteBloc(
        sportServices: _sportServices, userServices: _userServices);
    _favouriteBloc.add(LoadFavourite());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      color: Utilities.colorDarkerBlue,
      width: size.width,
      height: size.height,
      child: BlocListener<FavouriteBloc, FavouriteState>(
        listener: (context, state) {
          if (state is AddFavouriteSuccessState) {
            BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          }
          if (state is AddFavouriteFailState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(state.message),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
        },
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
            cubit: _favouriteBloc,
            builder: (context, state) {
              if (state is FavouriteLoadingState) {
                return Center(
                  child: Text('Loading'),
                );
              }
              if (state is FavouriteLoadSuccessState) {
                Stream<List<Sport>> sportStream = state.sport;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.25),
                    Text('What is your favourite sport ?',
                        style: TextStyle(
                            fontSize: size.height * 0.030,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: size.height * 0.05),
                    StreamBuilder<List<Sport>>(
                        stream: sportStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Wrap(
                                runSpacing: 5.0,
                                spacing: 5.0,
                                children: snapshot.data
                                    .map(
                                      (item) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSport = item.name;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: isSport == item.name
                                                  ? Utilities.colorDarkerBlue
                                                  : Utilities.colorMediumBlue,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size.height * 0.02),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black87
                                                      .withOpacity(0.3),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 4.0,
                                                  offset: Offset(3.0, 3.0),
                                                )
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                size.height * 0.02),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: size.width * 0.20,
                                                  height: size.height * 0.10,
                                                  child: Image.network(
                                                      item.imageSport),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                                Text(item.name,
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.020,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()
                                    .cast<Widget>());
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    SizedBox(height: size.height * 0.10),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.height * 0.03),
                      child: GestureDetector(
                        onTap: () {
                          _favouriteBloc.add(AddFavourite(sport: isSport));
                        },
                        child: Material(
                          elevation: 14,
                          borderRadius:
                              BorderRadius.circular(size.height * 0.03),
                          child: Container(
                            width: size.width,
                            child: Padding(
                                padding: EdgeInsets.all(size.height * 0.03),
                                child: Center(
                                  child: Text('GET STARTED',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Utilities.colorDarkerBlue,
                                          fontSize: size.height * 0.025)),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              if (state is FavouriteFailState) {
                return Center(
                  child: Text(state.message,
                      style: TextStyle(
                          fontSize: size.height * 0.020,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                );
              }

              return Container();
            }),
      ),
    )));
  }
}
