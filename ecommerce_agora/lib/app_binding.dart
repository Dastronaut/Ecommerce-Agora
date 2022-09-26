import 'package:ecommerce_agora/services/network/api_service.dart';
import 'package:ecommerce_agora/services/network/base_provider.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseProvider(), permanent: true);
    Get.put(ApiService(Get.find()), permanent: true);
  }
}
