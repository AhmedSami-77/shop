import 'package:demoshopapp/data/user_data_model.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final bool status;
   String? message;
  final UserDataModel data;

   UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message']??"",
      data: UserDataModel.fromJson(json['data'] ??
          {
            'id': 0,
            'name': '',
            'email': '',
            'phone': '',
            'points': 0,
            'credit': 0,
            'token': ''
          }),
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}
