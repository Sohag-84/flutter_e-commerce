import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productImages = [].obs;

  //for search product screen
  var inputText = "".obs;

  updateText(value) {
    inputText.value = value;
  }

  //fetch product image from firebase firestore
  fetchProductImage() async {
    QuerySnapshot snapshot = await firestore.collection('products').get();
    for (int i = 0; i < snapshot.docs.length; i++) {
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

  addToCartProduct(productId) async {
    CollectionReference _reference = firestore.collection("user-cart-items");
    _reference
        .doc(firebaseAuth.currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "product_name": productId['product_name'],
      'product_price': productId['product_price'],
      'product_image': productId['product_image'],
    }).then((value) => Fluttertoast.showToast(msg: "Added to cart"));
  }

  //Product add to favourite
  addToFavouriteProduct(productId) async {
    CollectionReference _reference = firestore.collection("user-favourite-items");
    _reference
        .doc(firebaseAuth.currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "product_name": productId['product_name'],
      'product_price': productId['product_price'],
      'product_image': productId['product_image'],
    }).then((value) => Fluttertoast.showToast(msg: "Added to favourite"));
  }

  //delete cart product
  deleteCartProduct({required productId}) {
    firestore
        .collection('user-cart-items')
        .doc(firebaseAuth.currentUser!.email)
        .collection("items")
        .doc(productId)
        .delete();
    Fluttertoast.showToast(msg: "Product is removed");
  }
}
