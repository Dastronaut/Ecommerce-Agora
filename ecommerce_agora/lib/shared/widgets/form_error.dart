import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/themes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FormError extends GetWidget<AuthController> {
  const FormError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: List.generate(controller.errors.length,
              (index) => formErrorText(error: controller.errors[index])),
        ));
  }

  Widget formErrorText({required String error}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/Error.svg",
            height: getProportionateScreenWidth(14),
            width: getProportionateScreenWidth(14),
          ),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          Text(error),
        ],
      ),
    );
  }
}
