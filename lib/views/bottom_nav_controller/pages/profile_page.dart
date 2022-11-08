// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constant.dart';
import 'package:e_commerce/controllers/profile_controller.dart';
import 'package:e_commerce/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _emailController;
  TextEditingController? _addressController;

  final controller = Get.put(ProfileController());

  setDataToTextField(data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180.r),
              image: DecorationImage(
                image: NetworkImage(
                    "https://scontent.fdac8-1.fna.fbcdn.net/v/t39.30808-6/299378381_767223317750044_5277371631662348582_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGnqUSwZe2NbeEOCt3L58ZYlG92uC_f0iOUb3a4L9_SI3n1oF7tZvEliUh_FrcifL4fZSEaM1sNCUOk8Cl4ei2Y&_nc_ohc=YVnEKw-dd68AX9huEF6&_nc_ht=scontent.fdac8-1.fna&oh=00_AfAOxCuehPIKp-vNYovSPTGlXAuOvVGbYBC7dRlNdcjrQQ&oe=636D64FA"),
              ),
            ),
          ),
          textField(
            title: "Name",
            controller: _nameController = TextEditingController(
              text: data!['username'],
            ),
          ),
          SizedBox(height: 5.h),
          textField(
            title: "Phone",
            controller: _phoneController = TextEditingController(
              text: data['phone'],
            ),
          ),
          SizedBox(height: 5.h),
          textField(
            title: "Email",
            controller: _emailController = TextEditingController(
              text: data['email'],
            ),
          ),
          SizedBox(height: 5.h),
          textField(
            title: "Address",
            controller: _addressController = TextEditingController(
              text: data['address'],
            ),
          ),
          SizedBox(height: 20.h),
          Obx(() {
            return CustomButton(
                controller.buttonValue == true ? "Update" : "Please wait...", () {
              updateProfile();
              controller.changeValue();
            });
          }),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  updateProfile() {
    CollectionReference reference = firestore.collection("user-form-data");
    return reference.doc(firebaseAuth.currentUser!.email).update({
      "username": _nameController!.text,
      'phone': _phoneController!.text,
      'email': _emailController!.text,
      'address': _addressController!.text,
    }).then(
      (value) {
        Fluttertoast.showToast(msg: "Successfully updated");
        controller.buttonValue.value = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: StreamBuilder(
            stream: firestore
                .collection('user-form-data')
                .doc(firebaseAuth.currentUser!.email)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              if (data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return setDataToTextField(data);
            },
          ),
        ),
      ),
    );
  }
}

Widget textField({required title, required controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$title:",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 5.h),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    ],
  );
}
