import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparing/models/sport.dart';
import 'package:sparing/services/sport_service.dart';
import 'package:sparing/utilities/utilities.dart';

import 'bloc/favourite_bloc.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  FavouriteBloc _favouriteBloc;
  SportServices _sportServices = SportServices();

  @override
  void initState() {
    _favouriteBloc = FavouriteBloc(sportServices: _sportServices);
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
      child: BlocBuilder<FavouriteBloc, FavouriteState>(
          cubit: _favouriteBloc,
          builder: (context, state) {
            if (state is FavouriteLoadingState) {
              return Center(
                child: Text(
                  'Loading'
                ),
              );
            }
            if (state is FavouriteLoadSuccess) {
              Stream<List<Sport>> sportStream = state.sport;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('What is your favourite sport ?',
                      style: TextStyle(
                          fontSize: size.height * 0.030,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: size.height * 0.05),
                  StreamBuilder<List<Sport>>(
                      stream: sportStream,
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          return Wrap(
                            runSpacing: 5.0,
                            spacing: 5.0,
                            children: snapshot.data
                                .map(
                                  (item) => Container(
                                    decoration: BoxDecoration(
                                        color: Utilities.colorMediumBlue,
                                        borderRadius: BorderRadius.circular(
                                            size.height * 0.02),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black87.withOpacity(0.3),
                                            blurRadius: 5.0,
                                            spreadRadius: 4.0,
                                            offset: Offset(3.0, 3.0),
                                          )
                                        ]),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(size.height * 0.02),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: size.width * 0.20,
                                            height: size.height * 0.10,
                                            child:
                                                Image.network(item.imageSport),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Text(item.name,
                                              style: TextStyle(
                                                  fontSize: size.height * 0.020,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList()
                                .cast<Widget>());
                        } else {
                          return CircularProgressIndicator();
                        }
                      })
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
    )));
  }
}
