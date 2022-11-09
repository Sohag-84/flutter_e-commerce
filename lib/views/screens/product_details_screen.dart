// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/constant.dart';
import 'package:e_commerce/controllers/carousel_image_controller.dart';
import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  final product;
  ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  final CarouselImageController _carouselController =
      Get.put(CarouselImageController());
  ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(180.r),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  StreamBuilder(
                    stream: firestore
                        .collection('user-favourite-items')
                        .doc(firebaseAuth.currentUser!.email)
                        .collection('items')
                        .where('product_name',
                            isEqualTo: product['product_name'])
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        Center(child: Text("Something is wrong!"));
                      }
                      return Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(180.r),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () => snapshot.data.docs.length == 0
                                ? _productController
                                    .addToFavouriteProduct(product)
                                : Fluttertoast.showToast(msg: "Already added"),
                            icon: Icon(
                              snapshot.data.docs.length == 0
                                  ? Icons.favorite_border
                                  : Icons.favorite,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 2.9,
              child: CarouselSlider(
                items: product['product_image']
                    .map<Widget>(
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
            ),
            SizedBox(height: 10.h),
            Obx(
              () => DotsIndicator(
                dotsCount: product['product_image'].length == 0
                    ? 1
                    : product['product_image'].length,
                position: (_carouselController.dotPosition).toDouble(),
                decorator: DotsDecorator(
                  activeColor: AppColors.deep_orange,
                  color: AppColors.deep_orange.withOpacity(0.5),
                  spacing: EdgeInsets.all(2.h),
                  activeSize: Size(8, 8),
                  size: Size(6, 6),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['product_name'],
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      "\$ ${product['product_price']}",
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      "${product['product_description']}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: StreamBuilder(
                  stream: firestore
                      .collection('user-cart-items')
                      .doc(firebaseAuth.currentUser!.email)
                      .collection('items')
                      .where('product_name', isEqualTo: product['product_name'])
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      Center(child: Text("Something is wrong!"));
                    }
                    return CustomButton(
                      "ADD TO CART",
                      () => snapshot.data.docs.length == 0
                          ? _productController.addToCartProduct(product)
                          : Fluttertoast.showToast(msg: "Already added"),
                    );
                  }),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
