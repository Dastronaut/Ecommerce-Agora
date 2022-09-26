import 'package:ecommerce_agora/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreTab extends GetView<HomeController> {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Center(
      child: Text('Explore Page'),
    ));
  }
}
