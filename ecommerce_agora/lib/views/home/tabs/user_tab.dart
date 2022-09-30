import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTab extends GetWidget<AuthController> {
  UserTab({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.yellow,
        child: Center(
          child: TextButton(
            child: const Text('Log out'),
            onPressed: () {
              authController.logout();
              Get.offAllNamed('/login');
            },
          ),
        ),
      ),
    );
  }
}
