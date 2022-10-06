import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/helper/keyboard.dart';
import 'package:ecommerce_agora/shared/constant/auth_const.dart';
import 'package:ecommerce_agora/shared/widgets/custom_surfix_icon.dart';
import 'package:ecommerce_agora/shared/widgets/default_button.dart';
import 'package:ecommerce_agora/shared/widgets/form_error.dart';
import 'package:ecommerce_agora/themes/size_config.dart';
import 'package:ecommerce_agora/views/authentication/forgot_password_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignForm extends GetWidget<AuthController> {
  const SignForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.singInFormKey,
        child: Column(
          children: [
            _buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            _buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            Row(
              children: [
                Checkbox(
                  value: controller.isRemember.value,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    controller.isRemember.value = value!;
                  },
                ),
                const Text("Remember me"),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    controller.clearLoginData();
                    Get.off(() => ForgotPasswordPage());
                  },
                  child: Text(
                    'forgot_password'.tr,
                    style:
                        const TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            const FormError(),
            SizedBox(height: getProportionateScreenHeight(20)),
            DefaultButton(
              text: 'continue'.tr,
              onPress: () {
                if (controller.singInFormKey.currentState!.validate()) {
                  controller.singInFormKey.currentState!.save();
                  // if all are valid then go to success screen
                  KeyboardUtil.hideKeyboard(context);
                  controller
                      .login(controller.emailController.text,
                          controller.passController.text)
                      .then((value) {
                    if (value) {
                      Get.offAllNamed('/home');
                      controller.clearLoginData();
                      controller.clearRegisterData();
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _buildEmailFormField() {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty) {
          controller.removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          controller.removeError(error: kInvalidEmailError);
        }
        return;
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

  TextFormField _buildPasswordFormField() {
    return TextFormField(
      controller: controller.passController,
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          controller.removeError(error: kPassNullError);
        } else if (value.length >= 5) {
          controller.removeError(error: kShortPassError);
        }
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
}
