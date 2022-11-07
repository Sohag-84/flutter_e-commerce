// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:e_commerce/constant.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/views/widgets/custom_button.dart';
import 'package:e_commerce/views/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserFormScreen extends StatefulWidget {
  final String email;
  const UserFormScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  List<String> gender = ["Male", "Female", "Other"];

  AuthController _authController = Get.put(AuthController());

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Submit the form to continue.",
                  style:
                      TextStyle(fontSize: 22.sp, color: AppColors.deep_orange),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                myTextField(
                    hintText: "enter your name",
                    keyBoardType: TextInputType.text,
                    controller: _nameController),
                myTextField(
                  hintText: "enter your phone number",
                  keyBoardType: TextInputType.number,
                  controller: _phoneController,
                ),
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "date of birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
                TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "choose your gender",
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                myTextField(
                  hintText: "enter your address",
                  keyBoardType: TextInputType.text,
                  controller: _addressController,
                ),

                SizedBox(
                  height: 50.h,
                ),

                // elevated button
                CustomButton(
                  "Continue",
                  () => _authController.sendUserDataToDb(
                    username: _nameController.text,
                    email: widget.email,
                    phone: _phoneController.text,
                    dob: _dobController.text,
                    address: _addressController.text,
                    gender: _genderController.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
