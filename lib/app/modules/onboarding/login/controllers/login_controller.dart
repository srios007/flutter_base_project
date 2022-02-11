import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base_project/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final count = 0.obs;
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  validateForm() {
    if (formKey.currentState!.validate()) {
      goToHome();
    }
  }

  goToHome() {
    Get.offAllNamed(Paths.HOME);
  }
  goToSignIn() {
    Get.offAllNamed(Paths.SIGNIN);
  }
}
