import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sparing/models/sport.dart';
import 'package:sparing/services/sport_service.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  SportServices _sportServices;

  FavouriteBloc({@required SportServices sportServices})
      : assert(sportServices != null),
        _sportServices = sportServices,
        super(FavouriteInitial());

  @override
  Stream<FavouriteState> mapEventToState(
    FavouriteEvent event,
  ) async* {
    if(event is LoadFavourite) {
        yield FavouriteLoadingState();
       try{
         yield FavouriteLoadSuccess(
           sport: _sportServices.getSport()
         );
       } catch(e) {
         yield FavouriteFailState(e.toString());
       }
    }
  }
}
