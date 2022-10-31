import 'package:equatable/equatable.dart';

import 'home_data_model.dart';

class HomeModel extends Equatable {
  bool status;
  HomeDataModel data;

  HomeModel({required this.data, required this.status});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        data: HomeDataModel.fromJson(json['data']), status: json['status']);
  }

  @override
  List<Object> get props => [
        status,
        data,
      ];
}
