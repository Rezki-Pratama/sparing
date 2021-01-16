import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sparing/services/user_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserServices _userServices;

  AuthBloc({@required UserServices userServices})
      : assert(userServices != null),
        _userServices = userServices,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      await Future.delayed(Duration(seconds: 5));
      yield* _mapStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }
  }

  Stream<AuthState> _mapStartedToState() async* {
    try {
      final isSignIn = await _userServices.isSignedIn();
      if (isSignIn) {
        final user = await _userServices.getUser();
        final isFirstTime = await _userServices.isFirstTime(user);
        if (!isFirstTime) {
          yield AuthenticatedButNotSet(user);
        } else {
          yield Authenticated(user);
        }
      } else {
        yield UnAuthenticated();
      }
    } catch (_) {
      yield UnAuthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    try {
      final isFirstTime =
          await _userServices.isFirstTime(await _userServices.getUser());
      if (!isFirstTime) {
        yield AuthenticatedButNotSet(await _userServices.getUser());
      } else {
        yield Authenticated(await _userServices.getUser());
      }
    } catch (_) {
      yield Authenticated(await _userServices.getUser());
    }
  }
}
