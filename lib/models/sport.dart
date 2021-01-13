import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Sport {
  final String uid, name, imageSport;

  Sport({@required this.uid, this.name, this.imageSport});

  factory Sport.fromJson(Map<String, dynamic> json){
    return Sport(
      uid: json['uid'],
      name: json['name'],
      imageSport: json['imageSport'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'imageSport': imageSport,
    };
  }
}