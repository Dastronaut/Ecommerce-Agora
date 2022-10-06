import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/helper/keyboard.dart';
import 'package:ecommerce_agora/shared/constant/auth_const.dart';
import 'package:ecommerce_agora/shared/widgets/custom_surfix_icon.dart';
import 'package:ecommerce_agora/shared/widgets/default_button.dart';
import 'package:ecommerce_agora/shared/widgets/form_error.dart';
import 'package:ecommerce_agora/themes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends GetWidget<AuthController> {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.singUpFormKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPassFormField(),
          const FormError(),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            onPress: () {
              if (controller.singUpFormKey.currentState!.validate()) {
                controller.singUpFormKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                controller
                    .register(controller.emailController.text.trim(),
                        controller.passController.text.trim())
                    .then((value) {
                  if (value) {
                    controller.passController.clear();
                    Get.offAllNamed('/login');
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      controller: controller.repassController,
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          controller.removeError(error: kPassNullError);
        } else if (value.isNotEmpty &&
            controller.passController.text ==
                controller.repassController.text) {
          controller.removeError(error: kMatchPassError);
        }
        controller.repassController.text = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          controller.addError(error: kPassNullError);
          return "";
        } else if ((controller.passController.text != value)) {
          controller.addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: textInputDecoration(
          "Confirm Password",
          'repassword_hint_text'.tr,
          const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg")),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: controller.passController,
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          controller.removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          controller.removeError(error: kShortPassError);
        }
        controller.passController.text = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          controller.addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          controller.addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: textInputDecoration("Password", 'password_hint_text'.tr,
          const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg")),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty) {
          controller.removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          controller.removeError(error: kInvalidEmailError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          controller.addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          controller.addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: textInputDecoration("Email", 'mail_hint_text'.tr,
          const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg")),
    );
  }
}
