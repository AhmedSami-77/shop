import 'package:equatable/equatable.dart';

class CategoriesDataModel extends Equatable {
  int currentPage;
  List<CategoriesData> data = [];

  CategoriesDataModel({required this.currentPage, required this.data});

  factory CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    return CategoriesDataModel(
        data: List<CategoriesData>.from(
            json['data'].map(
                  (element) => CategoriesData.fromJson(element),
            ) ,
        ),
        currentPage: json['current_page']);
  }

  @override
  List<Object> get props => [currentPage,data];
}

class CategoriesData extends Equatable {
  int id;
  String name;
  String image;

  CategoriesData({required this.name, required this.image, required this.id});

  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
        name: json['name'], id: json['id'], image: json['image']);
  }

  @override
  List<Object> get props => [id, name, image];
}
