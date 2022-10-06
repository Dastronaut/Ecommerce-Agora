import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/controllers/lang/language_controller.dart';
import 'package:ecommerce_agora/controllers/themes/themes_controller.dart';
import 'package:ecommerce_agora/extensions/string_extension.dart';
import 'package:ecommerce_agora/shared/constant/color_constants.dart';
import 'package:ecommerce_agora/shared/constant/firebase_constant.dart';
import 'package:ecommerce_agora/views/home/tabs/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTab extends GetWidget<AuthController> {
  UserTab({Key? key}) : super(key: key);
  final ThemesController _themesController = Get.find();
  final LanguageController _languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 100.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding: const EdgeInsets.symmetric(horizontal: 16),
                    title: Text(
                      'setting'.tr,
                      style: theme.textTheme.headline6,
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text('account'.tr,
                          style: theme.textTheme.headline6
                              ?.copyWith(fontWeight: FontWeight.w400)),
                      const SizedBox(height: 16),
                      controller.firebaseUser.value!.isAnonymous
                          ? Container(
                              height: 80,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Get.isDarkMode
                                      ? ColorConstants.gray700
                                      : Colors.grey.shade200),
                              child: Row(
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Get.isDarkMode
                                            ? ColorConstants.gray500
                                            : Colors.grey.shade300),
                                    child: Center(
                                      child: Icon(Icons.person,
                                          size: 32,
                                          color: Colors.grey.shade500),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  TextButton(
                                    onPressed: () {
                                      Get.offNamed('/login');
                                    },
                                    child: Text("Login",
                                        style: theme.textTheme.subtitle1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blue)),
                                  ),
                                  Text(' / ',
                                      style: theme.textTheme.subtitle1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.blue)),
                                  TextButton(
                                    onPressed: () {
                                      Get.offNamed('/login');
                                    },
                                    child: Text("Register",
                                        style: theme.textTheme.subtitle1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blue)),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              height: 80,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Get.isDarkMode
                                      ? ColorConstants.gray700
                                      : Colors.grey.shade200),
                              child: Row(
                                children: [
                                  controller.firebaseUser.value?.photoURL !=
                                          null
                                      ? InkWell(
                                          onTap: () {
                                            Get.to(() => ProfileScreen());
                                          },
                                          child: Container(
                                            width: 52,
                                            height: 52,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Image.network(
                                              controller.firebaseUser.value!
                                                  .photoURL!,
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (BuildContext ctx,
                                                  Widget child,
                                                  ImageChunkEvent?
                                                      loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.blue,
                                                    value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null &&
                                                            loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                              errorBuilder: (context, object,
                                                  stackTrace) {
                                                return const Icon(
                                                  Icons.account_circle,
                                                  size: 35,
                                                  color: Colors.grey,
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Get.to(() => ProfileScreen());
                                          },
                                          child: Container(
                                            width: 52,
                                            height: 52,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Get.isDarkMode
                                                    ? ColorConstants.gray500
                                                    : Colors.grey.shade300),
                                            child: Center(
                                              child: Icon(Icons.person,
                                                  size: 32,
                                                  color: Colors.grey.shade500),
                                            ),
                                          ),
                                        ),
                                  const SizedBox(width: 16),
                                  Obx(() => Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                controller.firebaseUser.value !=
                                                        null
                                                    ? controller
                                                            .firebaseUser
                                                            .value
                                                            ?.displayName ??
                                                        controller.firebaseUser
                                                            .value!.email!
                                                    : '',
                                                style: theme
                                                    .textTheme.titleLarge
                                                    ?.copyWith(
                                                        color: Colors.blue),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            controller.firebaseUser.value !=
                                                    null
                                                ? controller.firebaseUser.value!
                                                        .emailVerified
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                            const Icon(
                                                              Icons
                                                                  .verified_user_outlined,
                                                              color: Color(
                                                                  0xFFF56B3F),
                                                            ),
                                                            Text('verified'.tr,
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyText1
                                                                    ?.copyWith(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600))
                                                          ])
                                                    : InkWell(
                                                        onTap: () {
                                                          print(
                                                              'SENDING EMAIL...');
                                                          controller
                                                              .verifyEmail();
                                                        },
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .verified_user_outlined,
                                                                size: 18,
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                  'unverified'
                                                                      .tr,
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.copyWith(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade600))
                                                            ]),
                                                      )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                      const SizedBox(height: 32),
                      Text('setting'.tr,
                          style: theme.textTheme.headline6
                              ?.copyWith(fontWeight: FontWeight.w400)),
                      const SizedBox(height: 16),
                      GetBuilder<ThemesController>(builder: (_) {
                        return _buildListTile('appearance'.tr, Icons.dark_mode,
                            _.theme.tr.toCapitalized(), Colors.purple, theme,
                            onTab: () =>
                                _showThemeAppearanceModal(theme, _.theme));

                        // return Text(_.theme);
                      }),
                      const SizedBox(height: 8),
                      GetBuilder<LanguageController>(builder: (_) {
                        return _buildListTile('language'.tr, Icons.language,
                            _.lang.tr.toCapitalized(), Colors.orange, theme,
                            onTab: () =>
                                _showLangAppearanceModal(theme, _.lang));
                        // return Text(_.theme);
                      }),
                      const SizedBox(height: 8),
                      _buildListTile('notifications'.tr,
                          Icons.notifications_outlined, '', Colors.blue, theme,
                          onTab: () {}),
                      const SizedBox(height: 8),
                      _buildListTile(
                          'help'.tr, Icons.help, '', Colors.green, theme,
                          onTab: () {}),
                      const SizedBox(height: 8),
                      _buildListTile(
                          'logout'.tr, Icons.exit_to_app, '', Colors.red, theme,
                          onTab: () {
                        Get.offAllNamed('/login');
                        authController.logout();
                      }),
                    ],
                  ),
                  Text('version'.tr,
                      style: theme.textTheme.bodyText2
                          ?.copyWith(color: Colors.grey.shade500)),
                ],
              ),
            )));
  }

  Widget _buildListTile(
      String title, IconData icon, String trailing, Color color, theme,
      {onTab}) {
    return ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          width: 46,
          height: 46,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: color.withAlpha(30)),
          child: Center(
            child: Icon(
              icon,
              color: color,
            ),
          ),
        ),
        title: Text(title, style: theme.textTheme.subtitle1),
        trailing: SizedBox(
          width: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trailing,
                  style: theme.textTheme.bodyText1
                      ?.copyWith(color: Colors.grey.shade600)),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ],
          ),
        ),
        onTap: onTab);
  }

  _showThemeAppearanceModal(ThemeData theme, String current) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(16),
      height: 320,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'select_theme'.tr,
            style: theme.textTheme.subtitle1,
          ),
          const SizedBox(height: 32),
          _buildBottomSheetItem(
            Icons.brightness_5,
            Colors.blue,
            'light'.tr,
            theme,
            current,
            () {
              _themesController.setTheme('light');
              Get.back();
            },
            current == 'light' ? Colors.blue : Colors.transparent,
          ),
          const SizedBox(height: 16),
          _buildBottomSheetItem(
            Icons.brightness_2,
            Colors.orange,
            'dark'.tr,
            theme,
            current,
            () {
              _themesController.setTheme('dark');
              Get.back();
            },
            current == 'dark' ? Colors.orange : Colors.transparent,
          ),
          const SizedBox(height: 16),
          _buildBottomSheetItem(
            Icons.brightness_6,
            Colors.blueGrey,
            'system'.tr,
            theme,
            current,
            () {
              _themesController.setTheme('system');
              Get.back();
            },
            current == 'system' ? Colors.blueGrey : Colors.transparent,
          ),
        ],
      ),
    ));
  }

  _showLangAppearanceModal(ThemeData theme, String current) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(16),
      height: 320,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'select_lang'.tr,
            style: theme.textTheme.subtitle1,
          ),
          const SizedBox(height: 32),
          _buildLangBottomSheetItem(
            Icons.language_outlined,
            Colors.blue,
            'en_lang'.tr,
            theme,
            () {
              _languageController.setLang('en_lang');
              Get.back();
            },
            current == 'en_lang' ? Colors.blue : Colors.transparent,
          ),
          const SizedBox(height: 16),
          _buildLangBottomSheetItem(
            Icons.language_outlined,
            Colors.orange,
            'vi_lang'.tr,
            theme,
            () {
              _languageController.setLang('vi_lang');
              Get.back();
            },
            current == 'vi_lang' ? Colors.orange : Colors.transparent,
          ),
        ],
      ),
    ));
  }

  Widget _buildBottomSheetItem(IconData icon, Color iconColor, String text,
      ThemeData theme, String current, onTap, Color checkColor) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(text, style: theme.textTheme.bodyText1),
      onTap: onTap,
      trailing: Icon(
        Icons.check,
        color: checkColor,
      ),
    );
  }

  Widget _buildLangBottomSheetItem(IconData icon, Color iconColor, String text,
      ThemeData theme, onTap, Color checkColor) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(text, style: theme.textTheme.bodyText1),
      onTap: onTap,
      trailing: Icon(
        Icons.check,
        color: checkColor,
      ),
    );
  }
}
