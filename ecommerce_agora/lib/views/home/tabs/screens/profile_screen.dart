import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/shared/widgets/common_widget.dart';
import 'package:ecommerce_agora/shared/widgets/loading_view.dart';
import 'package:ecommerce_agora/views/home/tabs/user_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends GetWidget<AuthController> {
  ProfileScreen({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(theme),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProfileImage(),
                const SizedBox(height: 16),
                Text("Display name",
                    style: theme.textTheme.headline6
                        ?.copyWith(fontWeight: FontWeight.w400)),
                const SizedBox(height: 8),
                _buildEmailTextField(size),
                const SizedBox(height: 8),
                Text("Phone number",
                    style: theme.textTheme.headline6
                        ?.copyWith(fontWeight: FontWeight.w400)),
                const SizedBox(height: 8),
                _buildPhoneNumber(size),
                const SizedBox(height: 16),
                appButton(size, 'Update Information', () {
                  String phone = controller.dialCodeDigits.value +
                      controller.phoneNumberController.text;
                  authController.updateInfor(
                      '', controller.displayNameController.text);
                  print(controller.firebaseUser.toString());
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
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      title: Text(
        'Profile',
        style: theme.textTheme.titleLarge,
      ),
      centerTitle: true,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.off(() => UserTab());
          }),
    );
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

  Widget _buildPhoneNumber(Size size) {
    return Container(
      height: size.height / 12,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(0xFF4DA1B0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CountryCodePicker(
            onChanged: (country) {
              authController.dialCodeDigits.value = country.dialCode!;
            },
            showFlagMain: false,
            showFlagDialog: true,
            initialSelection: 'VN',
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            favorite: const ["+1", "US", "+84", "VN"],
            textStyle: GoogleFonts.inter(
              fontSize: 14.0,
              color: Colors.white70,
            ),
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
          Expanded(
            child: TextField(
              controller: controller.phoneNumberController,
              maxLines: 1,
              cursorColor: Colors.white70,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.inter(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                  hintText: 'Enter your phone number',
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
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () => authController.getImage(),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: controller.firebaseUser.value!.photoURL != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  controller.firebaseUser.value!.photoURL!,
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                  errorBuilder: (context, object, stackTrace) {
                    return const Icon(
                      Icons.account_circle,
                      size: 90,
                      color: Colors.grey,
                    );
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      width: 90,
                      height: 90,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              )
            : const Icon(
                Icons.account_circle,
                size: 90,
                color: Colors.grey,
              ),
      ),
    );
  }
}
