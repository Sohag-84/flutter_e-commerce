import 'package:e_commerce/constant.dart';
import 'package:e_commerce/controllers/bottom_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends StatelessWidget {
   BottomNavController({Key? key}) : super(key: key);

  final controller = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: Obx(
        () {
         return BottomNavigationBar(
           currentIndex: controller.pageIndex,
           elevation: 0,
           onTap: (value){
             controller.updatePageIndex(value);
           },
           items: [
             BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
             BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorite"),
             BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Home"),
           ],
         );
       }
     ),
      body: Obx(
         () {
          return IndexedStack(
            index: controller.pageIndex,
            children: page,
          );
        }
      )
    );
  }
}
