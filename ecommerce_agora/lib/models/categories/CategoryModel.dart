import 'package:ecommerce_agora/shared/widgets/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class CategoryModel {
  factory CategoryModel({
    required int id,
    required String name,
    required String image,
  }) {
    // TODO: implement
    throw UnimplementedError();
  }

  factory CategoryModel.fromJson(JSON json) =>
      CategoryModel(id: 0, name: 'name', image: 'image');
}
