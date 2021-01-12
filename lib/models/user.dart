import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid, name, teamName, photo, position;
  Timestamp age;
  GeoPoint location;

  User({
    this.uid,
    this.name,
    this.teamName,
    this.photo,
    this.position
  });
  
}