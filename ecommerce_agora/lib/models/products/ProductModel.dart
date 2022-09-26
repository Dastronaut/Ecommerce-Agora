import 'package:ecommerce_agora/models/categories/CategoryModel.dart';
import 'package:ecommerce_agora/shared/widgets/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class ProductModel {
  factory ProductModel({
    required int id,
    required String name,
    required String image,
    required String price,
    required String discount,
    required String discountPrice,
    required String brand,
    String? description,
    CategoryModel? category,
    List<String>? colors,
    List<String>? sizes,
    List<String>? images,
    String? rating,
    String? model,
    String? weight,
  }) {
    // TODO: implement
    throw UnimplementedError();
  }

  factory ProductModel.fromJson(JSON json) => ProductModel(
      id: 0,
      name: 'name',
      image: 'image',
      price: 'price',
      discount: 'discount',
      discountPrice: 'discountPrice',
      brand: 'brand');
}
