import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparing/presentations/auth/bloc/auth_bloc.dart';
import 'package:sparing/presentations/login/bloc/login_bloc.dart';
import 'package:sparing/presentations/widget/custom_textfield.dart';
import 'package:sparing/utilities/utilities.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
        }
        if (state is LoginFailState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(state.message),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: Utilities.colorDarkerBlue,
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width / 2,
                  child: Image.asset(
                    "assets/images/logo.png",
                    color: Colors.white,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(size.height * 0.03),
                    child: CustomTextField(
                      controller: _emailController,
                      obscureText: false,
                      size: size,
                      hintText: "Email",
                    )),
                Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: CustomTextField(
                      controller: _passwordController,
                      obscureText: true,
                      size: size,
                      hintText: "Password",
                    )),
                SizedBox(height: size.height * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.height * 0.03),
                  child: GestureDetector(
                    onTap: () {
                      _loginBloc.add(SignInWithCredential(
                          email: _emailController.text,
                          password: _passwordController.text));
                    },
                    child: Material(
                      elevation: 14,
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                      child: Container(
                        width: size.width,
                        child: Padding(
                            padding: EdgeInsets.all(size.height * 0.03),
                            child: Center(
                              child: Text('SIGN IN',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Utilities.colorDarkerBlue,
                                      fontSize: size.height * 0.025)),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Text('Or',
                    style: TextStyle(
                        color: Colors.white, fontSize: size.height * 0.025)),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      elevation: 14,
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                      child: Container(
                        child: Padding(
                            padding: EdgeInsets.all(size.height * 0.03),
                            child: Text('SIGN UP',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Utilities.colorDarkerBlue,
                                    fontSize: size.height * 0.025))),
                      ),
                    ),
                    Material(
                      elevation: 14,
                      borderRadius: BorderRadius.circular(size.height * 0.05),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(size.height * 0.02),
                          child: Container(
                            width: size.width * 0.10,
                            child: Image.asset(
                              "assets/images/google.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 14,
                      borderRadius: BorderRadius.circular(size.height * 0.05),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(size.height * 0.02),
                          child: Container(
                            width: size.width * 0.10,
                            child: Image.asset(
                              "assets/images/facebook.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    ));
  }
}
