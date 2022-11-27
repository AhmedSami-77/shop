class FavoriteModel {
  bool status;
  FavoriteData data;

  FavoriteModel({required this.status, required this.data});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
        status: json['status'], data: FavoriteData.fromJson(json['data']));
  }
}

class FavoriteData {
  int currentPage;
  List<FavoriteInfo> data = [];
  int total;

  FavoriteData(
      {required this.currentPage, required this.total, required this.data});

  factory FavoriteData.fromJson(Map<String, dynamic> json) {
    return FavoriteData(
        currentPage: json['current_page'],
        data: List<FavoriteInfo>.from(
            json['data'].map((element) => FavoriteInfo.fromJson(element))),
        total: json['total']);
  }
}

class FavoriteInfo {
  int id;
  FavoriteProduct product;

  FavoriteInfo({required this.id, required this.product});

  factory FavoriteInfo.fromJson(Map<String, dynamic> json) {
    return FavoriteInfo(
        id: json['id'], product: FavoriteProduct.fromJson(json['product']));
  }
}

class FavoriteProduct {
  int id;
  int price;
  int oldPrice;
  int discount;
  String image;
  String name;
  String description;

  FavoriteProduct({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.description,
    required this.discount,
    required this.name,
    required this.image,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
