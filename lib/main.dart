import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparing/presentations/auth/auth.dart';
import 'package:sparing/presentations/auth/bloc/auth_bloc.dart';
import 'package:sparing/presentations/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  await Firebase.initializeApp();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc()..add(AppStarted()),
      )
    ],
    child: Auth()));
}
