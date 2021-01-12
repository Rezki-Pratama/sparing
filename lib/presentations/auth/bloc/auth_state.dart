part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user);

  @override
  List<Object> get props => [user.uid];

  @override
  String toString() => " Authenticated {user.uid} ";
}

class AuthenticatedButNotSet extends AuthState {
  final User user;

  AuthenticatedButNotSet(this.user);

  //compare with equatable
  @override
  List<Object> get props => [user];
}

class UnAuthenticated extends AuthState {}
