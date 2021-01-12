import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users {
  final String uid, email, password, name, teamName, photo, position;
  final Timestamp age;
  final GeoPoint location;

  Users({@required this.uid, this.email, this.password, this.name, this.teamName, this.photo, this.position, this.age, this.location});

  factory Users.fromJson(Map<String, dynamic> json){
    return Users(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      teamName: json['teamName'],
      photo: json['photo'],
      position: json['position'],
      age: json['age'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'name': name,
      'teamName': teamName,
      'photo': photo,
      'position': position,
      'age': age,
      'location': location
    };
  }
}
