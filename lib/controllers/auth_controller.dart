// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/constant.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/views/auth/user_form.dart';
import 'package:e_commerce/views/bottom_nav_controller/bottom_nave_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var obscureText = true.obs;

  changeObscureText() {
    if (obscureText.value == true) {
      obscureText.value = false;
    } else {
      obscureText.value = true;
    }
  }

  //user registration
  Future userRegistration(
      {required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        var authCredential = userCredential.user;

        if (authCredential!.uid.isNotEmpty) {
          Get.to(() => UserFormScreen(email: email));
          // Get.to(() => UserFormScreen(email: authCredential.email.toString()));
        } else {
          Fluttertoast.showToast(msg: "Something is wrong!");
        }
      } else {
        Fluttertoast.showToast(msg: "Please,enter all the field");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "The password should be at least 6 character");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Please! Write a valid email');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //store user data in firebase
  sendUserDataToDb(
      {required username,
      required email,
      required phone,
      required dob,
      required address,
      required gender}) async {
    UserModel userModel = UserModel(
      username: username,
      email: email,
      phone: phone,
      uid: firebaseAuth.currentUser!.uid,
      dob: dob,
      address: address,
      gender: gender,
    );
    if (username.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        dob.isNotEmpty &&
        address.isNotEmpty &&
        gender.isNotEmpty) {
      await firestore
          .collection('user-form-data')
          .doc(firebaseAuth.currentUser!.email)
          .set(userModel.toJson())
          .then((value) {
        Get.to(
          () => BottomNavController(),
        );
        Fluttertoast.showToast(msg: "Registration successful");
      }).catchError((error) {
        Fluttertoast.showToast(
          msg: error.toString(),
        );
      });
    } else {
      Fluttertoast.showToast(msg: "Please,enter all the field");
    }
  }

  //user login
  Future userLogin({required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential =
            await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        var authCredential = userCredential.user;
        if (authCredential!.uid.isNotEmpty) {
          Get.to(() => BottomNavController());
        } else {
          Fluttertoast.showToast(msg: "Something is wrong!");
        }
      } else {
        Fluttertoast.showToast(msg: "Please,enter all the field");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //user logout
  userLogout() async {
    await firebaseAuth.signOut();
    Fluttertoast.showToast(msg: "Log out");
  }
}
