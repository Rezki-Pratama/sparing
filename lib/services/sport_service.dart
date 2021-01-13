import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparing/models/sport.dart';

class SportServices {
  final FirebaseFirestore _firebaseFirestore;

  SportServices({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  //Get Entries
    Stream<List<Sport>> getSport(){
      return _firebaseFirestore
        .collection('sport')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Sport.fromJson(doc.data()))
        .toList());
    }
}
