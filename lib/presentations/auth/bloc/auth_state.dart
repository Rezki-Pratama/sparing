part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final String userId;

  Authenticated({
    this.userId
  });

  @override
  List<Object> get props => [userId];

  @override
  String toString() => " Authenticated {userId} ";
}

class AuthenticatedButNotSet extends AuthState {
  final String userId;

  AuthenticatedButNotSet(this.userId);

  //compare with equatable
  @override
  List<Object> get props => [userId];
}

class UnAuthenticated extends AuthState {}
