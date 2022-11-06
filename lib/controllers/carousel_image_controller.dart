import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constant.dart';
import 'package:get/get.dart';

class CarouselImageController extends GetxController{

  var carouselImages = [].obs;
  var dotPosition = 0.obs;
  //for dot indicator
  changeDotIndicator(value){
    dotPosition.value = value;
  }

  //fetch carousel image from firebase firestore
  fetchCarouselImage() async{
    QuerySnapshot querySnapshot = await firestore.collection('carousel-slider').get();
    for(int i=0; i<querySnapshot.docs.length; i++){
      carouselImages.add(querySnapshot.docs[i]['img']);
    }
    return querySnapshot.docs;
  }

  @override
  void onInit() {
    fetchCarouselImage();
    super.onInit();
  }
}