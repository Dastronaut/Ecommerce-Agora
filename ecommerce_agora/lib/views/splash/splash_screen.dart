import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/shared/constant/firebase_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      chechSignedIn();
    });
  }

  Future<void> chechSignedIn() async {
    authController.isLoggedIn().then((value) {
      if (value) {
        Get.offNamed('/home');
      } else {
        Get.offNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Welcome to Agora",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Image.asset(
              'assets/splash.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Everything what you need?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
