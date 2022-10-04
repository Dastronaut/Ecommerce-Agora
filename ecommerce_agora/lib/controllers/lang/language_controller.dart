import 'package:ecommerce_agora/extensions/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final storage = GetStorage();
  String lang = 'en_lang';

  @override
  void onInit() {
    super.onInit();

    getLangState();
  }

  getLangState() {
    if (storage.read('language') != null) {
      return setLang(storage.read('language'));
    }

    setLang(LangType.EN.lang);
  }

  void setLang(String value) {
    lang = value;
    storage.write('language', value);

    if (value == LangType.EN.lang) Get.updateLocale(const Locale('en', 'US'));
    if (value == LangType.VI.lang) Get.updateLocale(const Locale('vi', 'VI'));

    update();
  }
}
