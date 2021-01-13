import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sparing/models/user.dart';
import 'package:sparing/services/user_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  UserServices _userServices;
  Users _user;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is SignInWithCredential){
      yield LoginLoadingState();
      try {
        var user = await _userServices.signInWithEmail(_user);
        yield LoginSuccessState(user); 
      } catch(e) {
        yield LoginFailState(e.toString());
      }
    }
  }
}
