import 'package:bloc/bloc.dart';
import 'package:demoshopapp/core/strings.dart';
import 'package:demoshopapp/data/change_favorites_model.dart';

import 'package:demoshopapp/data/dio.dart';
import 'package:demoshopapp/data/home_model.dart';
import 'package:demoshopapp/screens/products_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/categories_data_model.dart';
import '../data/categories_model.dart';
import '../screens/categories_screen.dart';
import '../screens/favourite_screen.dart';
import '../screens/settings_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  HomeModel? homeData;
  CategoriesModel? categoriesData;
  String? token;
  List<Widget> bottomScreen = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];
  Map<int, bool> favorites = {};
  ChangeFavoritesModel? favoritesData;

  void changeBottom(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  void getHomeData() {
    emit(HomeLoadingDataState());
    DioHelper.getData(endPointUrl: kHomeDataEndPoint, query: null, token: token)
        .then((value) {
      homeData = HomeModel.fromJson(value.data);
      //   print(homeData);
      homeData!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorite});
      });
      print(favorites.toString());
      emit(HomeSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorDataState());
    });
  }

  void getCategoriesData() {
    emit(CategoriesLoadingDataState());
    DioHelper.getData(
            endPointUrl: kCategoriesDataEndPoint, query: null, token: token)
        .then((value) {
      categoriesData = CategoriesModel.fromJson(value.data);
      // print(homeData);
      emit(CategoriesSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesErrorDataState());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId]=!favorites[productId]!;
    emit(ChangeSuccessDataState());
    DioHelper.postData(
            endPoint: kChangeFavoritesEndPoint,
            data: {'product_id': productId},
            token: token)
        .then((value) {
          favoritesData=ChangeFavoritesModel.fromJson(value.data);
          print(value.data);
          emit(ChangeFavoritesSuccessDataState());
    })
        .catchError((error) {
          emit(ChangeFavoritesErrorDataState());
    });
  }
}
