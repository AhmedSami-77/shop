class ChangeFavoritesModel {
  bool status;
  String message;

  ChangeFavoritesModel({required this.status, required this.message});

  factory ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    return ChangeFavoritesModel(
        status: json['status'], message: json['message']);
  }
}
