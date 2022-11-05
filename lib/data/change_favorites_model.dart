class ChangeFavoritesModel{
  int id;
  String message;
  ChangeFavoritesModel({required this.id,required this.message});
  factory ChangeFavoritesModel.fromJson(Map<String,dynamic> json){
    return ChangeFavoritesModel(id: json['id'],message: json['message']);
  }
}