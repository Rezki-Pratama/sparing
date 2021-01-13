import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparing/presentations/auth/auth.dart';
import 'package:sparing/presentations/auth/bloc/auth_bloc.dart';
import 'package:sparing/presentations/bloc_observer.dart';
import 'package:sparing/presentations/favourite/bloc/favourite_bloc.dart';
import 'package:sparing/presentations/login/bloc/login_bloc.dart';
import 'package:sparing/services/sport_service.dart';
import 'package:sparing/services/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  await Firebase.initializeApp();

  final UserServices _userServices = UserServices();
  final SportServices _sportServices = SportServices();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(
      create: (context) =>
          AuthBloc(userServices: _userServices)..add(AppStarted()),
    ),
    BlocProvider<FavouriteBloc>(
        create: (context) => FavouriteBloc(sportServices: _sportServices)),
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userServices: _userServices),
    )
  ], child: Auth()));
}
