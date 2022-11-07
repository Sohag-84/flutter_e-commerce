// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constant.dart';
import 'package:e_commerce/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _searchController = TextEditingController();
  final _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Obx( () {
              return Column(
                children: [
                  TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Search products here"),
                    onChanged: (value) {
                      _productController.inputText.value = value;
                    },
                  ),
                  StreamBuilder(
                    stream: firestore
                        .collection('products')
                        .where('product-name',
                            isGreaterThanOrEqualTo: (_productController.inputText.value))
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Something is wrong!",
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Expanded(
                        child: ListView(
                          children:
                              snapshot.data!.docs.map((DocumentSnapshot snapshot) {
                            var data = snapshot.data() as dynamic;
                            return Card(
                              elevation: 3,
                              child: ListTile(
                                title: Text(data['product-name']),
                                subtitle: Text(data['product-price'].toString()),
                                leading: Image.network(
                                    data['product-image'][0].toString()),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
