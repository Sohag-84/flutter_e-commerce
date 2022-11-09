// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constant.dart';
import 'package:e_commerce/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatelessWidget {
  //final product;
  FavouriteScreen({Key? key}) : super(key: key);

  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.1),
      body: SafeArea(
        child: StreamBuilder(
          stream: firestore
              .collection('user-favourite-items')
              .doc(firebaseAuth.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something is wrong"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data!.docs[index];
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  child: Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 90.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage(data['product_image'][0])),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              data['product_name'],
                              style: TextStyle(
                                fontSize: 20.sp,
                              ),
                            ),
                            Text("${data['product_price']}"),
                            StreamBuilder(
                                stream: firestore
                                    .collection('user-cart-items')
                                    .doc(firebaseAuth.currentUser!.email)
                                    .collection('items')
                                    .where('product_name',
                                        isEqualTo: data['product_name'])
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  return InkWell(
                                    onTap: () => snapshot.data!.docs.length == 0
                                        ? _productController
                                            .addToCartProduct(data)
                                        : Fluttertoast.showToast(
                                            msg: "Already added"),
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.deepOrange.withOpacity(.70),
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Add to cart",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: EdgeInsets.all(8.w),
                          child: InkWell(
                            onTap: () => _productController
                                .deleteFavouriteProduct(productId: data.id),
                            child: Container(
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(180.r),
                                color: Colors.red.withOpacity(.70),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
