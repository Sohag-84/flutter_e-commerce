import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AppColors{
  static const Color deep_orange = Color(0xFFFF6B6B);
}

//Page
final page = [
  Center(child: Text("Home screen"),),
  Center(child: Text("Favorite screen"),),
  Center(child: Text("Cart screen"),),
];

//firebase
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;