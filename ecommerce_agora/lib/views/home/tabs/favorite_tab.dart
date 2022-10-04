import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/shared/constant/firebase_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteTab extends GetWidget<AuthController> {
  const FavoriteTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.yellow,
        child: Center(
          child: TextButton(
            child: const Text('sign out'),
            onPressed: () {
              Get.offAllNamed('/login');
              authController.logout();
            },
          ),
        ),
      ),
    );
  }
}
