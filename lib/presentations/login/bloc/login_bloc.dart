import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sparing/services/user_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserServices _userServices;

  LoginBloc({@required UserServices userServices})
      : assert(userServices != null),
        _userServices = userServices,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignInWithCredential) {
      yield LoginLoadingState();
      try {
         var user = await _userServices.signInWithEmailAndPassword(
            event.email, event.password);
            print(user);
        yield LoginSuccessState(user);
      } catch (e) {
        yield LoginFailState(e.toString());
      }
    }
  }
}
