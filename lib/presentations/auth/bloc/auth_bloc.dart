import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sparing/models/user.dart';
import 'package:sparing/services/user_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  UserServices _userServices;
  User _user;

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
        final uid = await _userServices.getUser();
        final isFirstTime = await _userServices.isFirstTime(_user);
        if (!isFirstTime) {
          yield AuthenticatedButNotSet(_user);
        } else {
          yield Authenticated(_user);
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
