import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/shared/widgets/constant/text_field_constants.dart';
import 'package:ecommerce_agora/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetWidget<AuthController> {
  ProfileScreen({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
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
                              loadingBuilder: (BuildContext context,
                                  Widget child,
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
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
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
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    TextField(
                      decoration: kTextInputDecoration.copyWith(
                          hintText: 'Write your Name'),
                      controller: authController.displayNameController,
                      onChanged: (value) {
                        authController.firebaseUser.value
                            ?.updateDisplayName(value);
                      },
                      focusNode: authController.focusNodeNickname,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Select Country Code',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CountryCodePicker(
                        onChanged: (country) {
                          authController.dialCodeDigits.value =
                              country.dialCode!;
                        },
                        initialSelection: 'VN',
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        favorite: const ["+1", "US", "+84", "VN"],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Obx(() => TextField(
                          decoration: kTextInputDecoration.copyWith(
                            hintText: 'Phone Number',
                            prefix: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                authController.dialCodeDigits.value,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          controller: authController.phoneController,
                          maxLength: 12,
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Update Info'),
                    )),
              ],
            ),
          ),
          Positioned(
              child: authController.isLoading.value
                  ? const LoadingView()
                  : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
