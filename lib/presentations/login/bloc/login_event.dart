part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SignInWithCredential extends LoginEvent {
  final String email, password;
  SignInWithCredential({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
