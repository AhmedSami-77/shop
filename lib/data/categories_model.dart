import 'package:demoshopapp/data/categories_data_model.dart';
import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable{
  bool status;
  CategoriesDataModel data;
  CategoriesModel({required this.data,required this.status});
  factory CategoriesModel.fromJson(Map<String,dynamic> json){
    return CategoriesModel(data:CategoriesDataModel.fromJson(json['data']),status: json['status']);
  }

  @override
  // TODO: implement props
  List<Object> get props => [status,data];
}
