
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nizipet1/auth/verifycode.dart';


abstract class ForgetPasswordController extends GetxController {
 checkemail();
 goToVerifyCode();
}

class ForgetPasswordImp extends ForgetPasswordController {
  late TextEditingController email;

  @override
  checkemail() {
  }

  @override
  goToVerifyCode() {
    // Get.off(AppRoute.VerifyCode);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    super.dispose();
  }
}

class AppRoute {
}