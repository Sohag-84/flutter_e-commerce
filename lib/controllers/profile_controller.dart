import 'package:get/get.dart';

class ProfileController extends GetxController{

  RxBool buttonValue = false.obs;

  changeValue(){
    if(buttonValue.value == false){
      buttonValue.value = true;
    }else{
      buttonValue.value = false;
    }
    update();
  }
}