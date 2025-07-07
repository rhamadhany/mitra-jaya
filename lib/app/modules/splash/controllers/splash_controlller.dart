import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitra_jaya/app/modules/home/views/home_view.dart';
import 'package:mitra_jaya/app/routes/app_pages.dart';

class SplashControlller extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );
    GlobalVarible.initialLoading.value = true;

    animationController.forward().then((_) {
      Get.offAndToNamed(Routes.HOME);
      GlobalVarible.initialLoading.value = false;
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
