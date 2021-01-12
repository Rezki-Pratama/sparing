import 'package:flutter/material.dart';
import 'package:sparing/utilities/utilities.dart';

class CustomTextField extends StatelessWidget {
  final Size size;
  final TextEditingController controller;
  final Function validator;
  final String hintText;
  final bool obscureText;

  CustomTextField(
      {this.size,
      this.controller,
      this.validator,
      this.hintText,
      this.obscureText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.01, horizontal: size.height * 0.01),
      child: TextFormField(
        controller: controller,
        autovalidate: true,
        obscureText: obscureText,
        validator: validator,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border:
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.05),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.white
                )
              ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.width * 0.05),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.white
                )
              ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.width * 0.05),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.white
                )
              ),
          hintText: hintText,
          errorStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white, fontSize: size.height * 0.02),
        ),
      ),
    );
  }
}
