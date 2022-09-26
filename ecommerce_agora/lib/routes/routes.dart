import 'package:ecommerce_agora/controllers/auth/auth_binding.dart';
import 'package:ecommerce_agora/controllers/home/home_binding.dart';
import 'package:ecommerce_agora/views/authentication/login_page.dart';
import 'package:ecommerce_agora/views/authentication/splash_screen.dart';
import 'package:ecommerce_agora/views/home/home_page.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const initial = '/splash';

  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashPage(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: '/product/:id',
    //   page: () => const ProductPage(),
    //   binding: ProductBinding(),
    // )
  ];
}