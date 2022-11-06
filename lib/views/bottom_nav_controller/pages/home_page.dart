// ignore_for_file: prefer_const_constructors, unused_field

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/constant.dart';
import 'package:e_commerce/controllers/bottom_controller.dart';
import 'package:e_commerce/controllers/carousel_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final CarouselImageController _carouselController =
      Get.put(CarouselImageController());
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55.h,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Search products here",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.r),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.r),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 55.h,
                  width: 55.w,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(5.r),
                    color: AppColors.deep_orange,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28.h,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
            SizedBox(height: 15.h),
            Obx(
              () {
                return AspectRatio(
                  aspectRatio: 3.0,
                  child: CarouselSlider(
                    items: _carouselController.carouselImages
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(right: 1.w),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(e),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      //enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        _carouselController.changeDotIndicator(val);
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10.h),
            Obx(
              () => DotsIndicator(
                dotsCount: _carouselController.carouselImages.value.length == 0
                    ? 1
                    : _carouselController.carouselImages.value.length,
                position: _carouselController.dotPosition.value.toDouble(),
                decorator: DotsDecorator(
                  activeColor: AppColors.deep_orange,
                  color: AppColors.deep_orange.withOpacity(0.5),
                  spacing: EdgeInsets.all(2.h),
                  activeSize: Size(8, 8),
                  size: Size(6, 6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
