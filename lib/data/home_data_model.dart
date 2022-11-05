import 'package:equatable/equatable.dart';

class HomeDataModel extends Equatable {
  List<BannerModel> banners;
  List<ProductModel> products;

  HomeDataModel({required this.banners, required this.products});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      banners: List<BannerModel>.from(
          ( json['banners'].map(
          (element) => BannerModel.fromJson(element),
        ) ),
      ),
      products: List<ProductModel>.from(
          json['products'].map(
          (element) => ProductModel.fromJson(element),
          ),
      ),
    );
  }

  @override
  List<Object?> get props => [
        banners,
        products,
      ];
}

class BannerModel extends Equatable {
  int id;
  String image;

  BannerModel({required this.id, required this.image});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(id: json['id'], image: json['image']);
  }

  @override
  List<Object> get props => [
        id,
        image,
      ];
}

class ProductModel extends Equatable {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavorite;
  bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.inFavorite,
    required this.inCart,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      inFavorite: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }

  @override
  List<Object> get props => [
        id,
        price,
        oldPrice,
        discount,
        image,
        name,
        inFavorite,
        inCart,
      ];
}
