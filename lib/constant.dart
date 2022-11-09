// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/views/bottom_nav_controller/pages/cart_page.dart';
import 'package:e_commerce/views/bottom_nav_controller/pages/home_page.dart';
import 'package:e_commerce/views/bottom_nav_controller/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AppColors{
  static const Color deep_orange = Color(0xFFFF6B6B);
}

//Page
final page = [
  HomePage(),
  Center(child: Text("Favorite screen"),),
  CartPage(),
  ProfilePage(),
];

//firebase
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;