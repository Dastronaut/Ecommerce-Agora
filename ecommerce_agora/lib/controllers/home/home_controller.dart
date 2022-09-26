import 'package:ecommerce_agora/views/home/tabs/card_tab.dart';
import 'package:ecommerce_agora/views/home/tabs/explore_tab.dart';
import 'package:ecommerce_agora/views/home/tabs/favorite_tab.dart';
import 'package:ecommerce_agora/views/home/tabs/user_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late PageController pageController;

  var currentPage = 0.obs;

  List<Widget> pages = [
    const ExploreTab(),
    const FavoriteTab(),
    const CardTab(),
    const UserTab(),
  ];

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);

    super.onInit();
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
