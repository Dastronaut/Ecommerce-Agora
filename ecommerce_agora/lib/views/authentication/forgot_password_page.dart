import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/shared/widgets/common_widget.dart';
import 'package:ecommerce_agora/shared/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends GetWidget<AuthController> {
  ForgotPasswordPage({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Forgot password',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Your email",
                        style: theme.textTheme.headline6
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    const SizedBox(height: 8),
                    _buildEmailTextField(size),
                    const SizedBox(height: 16),
                    appButton(size, 'Send', () {
                      authController.forgotPassword(
                          controller.emailController.text.trim());
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.back();
                    }),
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

  Widget _buildEmailTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF4DA1B0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //mail icon
            const Icon(
              Icons.mail_rounded,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            //divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            //email address textField
            Expanded(
              child: TextField(
                controller: controller.emailController,
                maxLines: 1,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    hintText: 'Enter your gmail address',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
