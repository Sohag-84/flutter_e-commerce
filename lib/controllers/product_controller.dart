import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constant.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var productImages = [].obs;


  //fetch product image from firebase firestore
  fetchProductImage() async{
    QuerySnapshot snapshot = await firestore.collection('products').get();
    for(int i=0; i<snapshot.docs.length; i++){
      //carouselImages.add(querySnapshot.docs[i]['img']);
      var data = snapshot.docs[i];
      productImages.add({
        'product_name': data['product-name'],
        'product_description': data['product-description'],
        'product_image': data['product-image'],
        'product_price': data['product-price'],
      });
    }
    return snapshot.docs;
  }

  @override
  void onInit() {
    fetchProductImage();
    super.onInit();
  }
}