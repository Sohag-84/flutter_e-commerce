// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:e_commerce/constant.dart';
import 'package:e_commerce/controllers/bottom_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomNavController extends StatelessWidget {
  BottomNavController({Key? key}) : super(key: key);

  final controller = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "E-Commerce",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 25.sp,
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            currentIndex: controller.pageIndex,
            elevation: 0,
            onTap: (value) {
              controller.updatePageIndex(value);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Home"),
            ],
          );
        },
      ),
      body: Obx(
        () {
          return IndexedStack(
            index: controller.pageIndex,
            children: page,
          );
        },
      ),
    );
  }
}
