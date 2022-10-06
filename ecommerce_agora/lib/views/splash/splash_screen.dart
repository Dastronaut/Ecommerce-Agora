import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/controllers/splash/splash_controller.dart';
import 'package:ecommerce_agora/shared/constant/auth_const.dart';
import 'package:ecommerce_agora/shared/widgets/default_button.dart';
import 'package:ecommerce_agora/themes/size_config.dart';
import 'package:ecommerce_agora/views/splash/components/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetWidget<SplashController> {
  SplashPage({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

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
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    controller.currentPage.value = value;
                  },
                  itemCount: controller.splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: controller.splashData[index]["image"],
                    text: controller.splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.splashData.length,
                              (index) => buildDot(index: index),
                            ),
                          )),
                      const Spacer(flex: 3),
                      DefaultButton(
                        text: 'continue'.tr,
                        onPress: chechSignedIn,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: controller.currentPage.value == index ? 20 : 6,
      decoration: BoxDecoration(
        color: controller.currentPage.value == index
            ? kPrimaryColor
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
