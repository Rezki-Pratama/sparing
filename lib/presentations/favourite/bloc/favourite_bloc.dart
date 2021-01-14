import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sparing/models/sport.dart';
import 'package:sparing/services/sport_service.dart';
import 'package:sparing/services/user_service.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  SportServices _sportServices;
  UserServices _userServices;

  FavouriteBloc(
      {@required SportServices sportServices, UserServices userServices})
      : assert(sportServices != null && userServices != null),
        _sportServices = sportServices,
        _userServices = userServices,
        super(FavouriteInitial());

  @override
  Stream<FavouriteState> mapEventToState(
    FavouriteEvent event,
  ) async* {
    if (event is LoadFavourite) {
      yield FavouriteLoadingState();
      try {
        yield FavouriteLoadSuccessState(sport: _sportServices.getSport());
      } catch (e) {
        yield FavouriteFailState(e.toString());
      }
    } else if (event is AddFavourite) {
      final user = await _userServices.getUser();
      try {
        await _sportServices.setFavouriteSport(user: user, sport: event.sport);
        yield AddFavouriteSuccessState();
      } catch (e) {
        yield AddFavouriteFailState(e.toString());
      }
    }
  }
}
