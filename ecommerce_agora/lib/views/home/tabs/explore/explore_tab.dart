import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_agora/controllers/home/home_controller.dart';
import 'package:ecommerce_agora/models/offers/OfferModel.dart';
import 'package:ecommerce_agora/themes/size_config.dart';
import 'package:ecommerce_agora/views/home/tabs/explore/components/categories.dart';
import 'package:ecommerce_agora/views/home/tabs/explore/components/home_header.dart';
import 'package:ecommerce_agora/views/home/tabs/explore/components/popular_product.dart';
import 'package:ecommerce_agora/views/home/tabs/explore/components/special_offers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreTab extends GetView<HomeController> {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            _buildOfferCarousel(context),
            _buildOfferIndicator(),
            const Categories(),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            const PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCarousel(context) {
    return Obx(() => SizedBox(
          height: SizeConfig.screenHeight * 0.25,
          width: SizeConfig.screenWidth,
          child: CarouselSlider.builder(
            carouselController: controller.carouselController,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 1,
              initialPage: 0,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) => controller.changeBanner(index),
            ),
            itemCount: controller.activeOffers.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    _buildOffer(controller.activeOffers[itemIndex]),
          ),
        ));
  }

  Widget _buildOffer(OfferModel offer) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            imageUrl: offer.image,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }

  Widget _buildOfferIndicator() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.activeOffers.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Get.isDarkMode ? Colors.white : Colors.blueGrey)
                      .withOpacity(controller.currentBanner.value == entry.key
                          ? 0.9
                          : 0.2)),
            );
          }).toList(),
        ));
  }
}
