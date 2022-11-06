import 'package:get/get.dart';

class NavController extends GetxController{
  RxInt _pageIndex = 0.obs;
  int get pageIndex => _pageIndex.value;
  updatePageIndex(value){
    _pageIndex.value = value;
  }
}