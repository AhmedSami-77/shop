import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int points;
  final int credit;
  final String token;

  const UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      points: json['points'],
      credit: json['credit'],
      token: json['token'],
    );
  }

  @override
  List<Object> get props => [id, name, email, phone, token];
}
