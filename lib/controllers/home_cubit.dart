import 'package:bloc/bloc.dart';
import 'package:demoshopapp/core/strings.dart';
import 'package:demoshopapp/core/variabls.dart';
import 'package:demoshopapp/data/change_favorites_model.dart';

import 'package:demoshopapp/data/dio.dart';
import 'package:demoshopapp/data/home_model.dart';
import 'package:demoshopapp/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/categories_model.dart';
import '../data/favorites_model.dart';
import '../data/user_model.dart';
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

  List<Widget> bottomScreen = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];
  Map<int, bool> favorites = {};
  ChangeFavoritesModel? favoritesData;
  FavoriteModel? favoritesModel;
  UserModel? usermodel;

  void changeBottom(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  void getHomeData() {
    emit(HomeLoadingDataState());
    DioHelper.getData(
            endPointUrl: kHomeDataEndPoint, query: null, token: vToken)
        .then((value) {
      homeData = HomeModel.fromJson(value.data);
      homeData!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorite});
      });
      //print(favorites.toString());
      emit(HomeSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorDataState());
    });
  }

  void getCategoriesData() {
    emit(CategoriesLoadingDataState());
    DioHelper.getData(endPointUrl: kCategoriesDataEndPoint, token: vToken)
        .then((value) {
      categoriesData = CategoriesModel.fromJson(value.data);
      // print(homeData);
      emit(CategoriesSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesErrorDataState());
    });
  }

  void getFavoritesData() {
    emit(FavoritesLoadingDataState());

    DioHelper.getData(endPointUrl: kFavoritesEndPoint, token: vToken)
        .then((value) {
      favoritesModel = FavoriteModel.fromJson(value.data);
      // print(favoritesModel!.data);
      emit(FavoritesSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(FavoritesErrorDataState());
    });
  }

  void getProfileData() {
    emit(ProfileLoadingDataState());
    DioHelper.getData(endPointUrl: kProfileEndPoint, token: vToken)
        .then((value) {
      usermodel = UserModel.fromJson(value.data);
      print(usermodel!.data);
      emit(ProfileSuccessDataState(usermodel!));
    }).catchError((error) {
      print(error.toString());
      emit(ProfileErrorDataState());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(
      ChangeSuccessDataState(),
    );
    DioHelper.postData(
            endPoint: kFavoritesEndPoint,
            data: {'product_id': productId},
            token: vToken)
        .then((value) {
      favoritesData = ChangeFavoritesModel.fromJson(value.data);
      //  print(value.data);
      if (favoritesData!.status) {
        getFavoritesData();
      } else {
        favorites[productId] = !favorites[productId]!;
      }
      emit(
        ChangeFavoritesSuccessDataState(favoritesData!),
      );
    }).catchError((error) {
      emit(
        ChangeFavoritesErrorDataState(),
      );
    });
  }

}
