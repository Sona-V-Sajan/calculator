import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ThemeController extends GetxController{

  var isDark = false;
  void changeTheme(state){
    if(state == true){
      Get.changeTheme(ThemeData.dark());
    }
    else{
      Get.changeTheme(ThemeData.light());
    }
    update();
  }

}

