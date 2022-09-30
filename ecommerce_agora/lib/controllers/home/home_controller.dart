import 'package:carousel_slider/carousel_controller.dart';
import 'package:ecommerce_agora/models/categories/CategoryModel.dart';
import 'package:ecommerce_agora/models/offers/OfferModel.dart';
import 'package:ecommerce_agora/models/products/ProductModel.dart';
import 'package:ecommerce_agora/providers/category_provider.dart';
import 'package:ecommerce_agora/providers/offer_provider.dart';
import 'package:ecommerce_agora/providers/product_provider.dart';
import 'package:ecommerce_agora/views/home/tabs/card_tab.dart';
import 'package:ecommerce_agora/views/home/tabs/explore_tab.dart';
import 'package:ecommerce_agora/views/home/tabs/favorite_tab.dart';
import 'package:ecommerce_agora/views/home/tabs/user_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final OfferProvider _offerProvider;
  HomeController(this._offerProvider);

  late PageController pageController;
  late CarouselController carouselController;
  late final CategoryProvider _categoryProvider = Get.find();
  late final ProductProvider _productProvider = Get.find();

  RxInt currentPage = 0.obs;
  RxInt currentBanner = 0.obs;

  RxList<OfferModel> activeOffers = <OfferModel>[].obs;
  RxList categories = <CategoryModel>[].obs;
  RxList discountedProducts = <ProductModel>[].obs;

  List<Widget> pages = [
    const ExploreTab(),
    const FavoriteTab(),
    const CardTab(),
    UserTab(),
  ];

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    carouselController = CarouselController();

    getOffers();
    getCategories();
    getDiscountedProducts();
    super.onInit();
  }

  void getOffers() {
    _offerProvider.getOffers().then((offers) {
      activeOffers.value = offers;
    });
  }

  void getCategories() {
    _categoryProvider.getCategories().then((categories) {
      this.categories.value = categories;
    });
  }

  void getDiscountedProducts() {
    _productProvider.getDiscountedProducts().then((products) {
      discountedProducts(products);
      print(products);
    });
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void changeBanner(int index) {
    currentBanner.value = index;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
