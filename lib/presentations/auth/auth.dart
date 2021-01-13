import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparing/presentations/favourite/favourite.dart';
import 'package:sparing/presentations/home/home.dart';
import 'package:sparing/presentations/login/login.dart';
import 'package:sparing/presentations/splash.dart';

import 'bloc/auth_bloc.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if(state is AuthInitial) {
            return Splash();
          }
          if(state is Authenticated) {
            return Home();
          }
          if(state is AuthenticatedButNotSet) {
            return Favourite();
          }
          if(state is UnAuthenticated) {
            return Login();
          } else {
            return Container();
          }

        },
      )
    );
  }
}