import 'package:ecommerce_agora/controllers/home/home_controller.dart';
import 'package:ecommerce_agora/providers/category_provider.dart';
import 'package:ecommerce_agora/providers/offer_provider.dart';
import 'package:ecommerce_agora/providers/product_provider.dart';
import 'package:ecommerce_agora/repositories/CategoryRepository.dart';
import 'package:ecommerce_agora/repositories/OfferRepository.dart';
import 'package:ecommerce_agora/repositories/ProductRepository.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferRepository>(() => OfferRepository(Get.find()));
    Get.lazyPut<OfferProvider>(() => OfferProvider(Get.find()));

    Get.lazyPut<CategoryRepository>(() => CategoryRepository(Get.find()));
    Get.lazyPut<CategoryProvider>(() => CategoryProvider(Get.find()));

    Get.lazyPut<ProductRepository>(() => ProductRepository(Get.find()));
    Get.lazyPut<ProductProvider>(() => ProductProvider(Get.find()));

    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
