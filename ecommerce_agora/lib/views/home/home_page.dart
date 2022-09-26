import 'package:ecommerce_agora/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        notchMargin: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Obx((() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomAppBarItem(page: 0, icon: IconlyLight.home),
                  _bottomAppBarItem(page: 1, icon: IconlyLight.bookmark),
                  _bottomAppBarItem(page: 2, icon: IconlyLight.buy),
                  _bottomAppBarItem(page: 3, icon: IconlyLight.profile),
                ],
              ))),
        ),
      ),
      body: PageView(
        controller: _homeController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [..._homeController.pages],
      ),
    );
  }

  Widget _bottomAppBarItem({icon, page}) {
    return ZoomTapAnimation(
      onTap: () => _homeController.goToTab(page),
      child: Icon(
        icon,
        color: _homeController.currentPage == page ? Colors.blue : Colors.grey,
        size: 22,
      ),
    );
  }
}
