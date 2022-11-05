import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String phone;
  String uid;
  final dob;
  String address;
  final gender;

  UserModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.uid,
    required this.dob,
    required this.address,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'phone': phone,
    'uid': uid,
    'dob': dob,
    'address': address,
    'gender': gender,
  };
  //retrieve data from firebase
  static UserModel fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      username: snap['username'],
      email: snap['email'],
      phone: snap['phone'],
      uid: snap['uid'],
      dob: snap['dob'],
      address: snap['address'],
      gender: snap['gender'],
    );
  }
}
