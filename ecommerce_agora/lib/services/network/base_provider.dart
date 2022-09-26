import 'package:ecommerce_agora/services/network/api_constant.dart';
import 'package:ecommerce_agora/services/network/interceptors/request_interceptor.dart';
import 'package:ecommerce_agora/services/network/interceptors/response_interceptor.dart';
import 'package:get/get_connect/connect.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiConstant.baseUrl;
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
  }
}
