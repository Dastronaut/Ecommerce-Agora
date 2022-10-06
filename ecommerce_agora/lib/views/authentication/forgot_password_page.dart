import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/shared/constant/auth_const.dart';
import 'package:ecommerce_agora/shared/widgets/custom_surfix_icon.dart';
import 'package:ecommerce_agora/shared/widgets/default_button.dart';
import 'package:ecommerce_agora/shared/widgets/loading_view.dart';
import 'package:ecommerce_agora/themes/size_config.dart';
import 'package:ecommerce_agora/views/authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends GetWidget<AuthController> {
  ForgotPasswordPage({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: _buildAppBar(theme),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(30)),
                    _buildEmailFormField(),
                    const SizedBox(height: 16),
                    DefaultButton(
                      text: 'send'.tr,
                      onPress: () {
                        controller.clearRegisterData();
                        authController.forgotPassword(
                            controller.emailController.text.trim());
                        Get.back();
                      },
                    ),
                  ],
                ),
                Positioned(
                    child: authController.isLoading.value
                        ? const LoadingView()
                        : const SizedBox.shrink()),
              ],
            ),
          ),
        ));
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      title: Text(
        'forgot_password'.tr,
        style: theme.textTheme.titleLarge,
      ),
      centerTitle: true,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.off(() => const LoginPage());
          }),
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
}
