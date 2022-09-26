import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared/widgets/typedef.dart';

@freezed
class OfferModel {
  factory OfferModel({
    required int id,
    required String title,
    required String description,
    required String image,
    required String price,
    required String discount,
    required String discountPrice,
  }) {
    // TODO: implement
    throw UnimplementedError();
  }

  factory OfferModel.fromJson(JSON json) => OfferModel(
      id: 0,
      title: 'title',
      description: 'description',
      image: 'image',
      price: 'price',
      discount: 'discount',
      discountPrice: 'discountPrice');
}
