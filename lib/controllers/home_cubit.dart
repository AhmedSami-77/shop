import 'package:bloc/bloc.dart';
import 'package:demoshopapp/core/strings.dart';
import 'package:demoshopapp/data/dio.dart';
import 'package:demoshopapp/data/home_model.dart';
import 'package:demoshopapp/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../screens/categories_screen.dart';
import '../screens/favourite_screen.dart';
import '../screens/settings_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
     HomeModel? homeData;
  String? token;
  List<Widget> bottomScreen = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  void getHomeData() {
    emit(HomeLoadingDataState());
    DioHelper.getData(endPointUrl: kHomeDataEndPoint, query: null,token:token )
        .then((value){
          homeData = HomeModel.fromJson(value.data);
          print(homeData);
          emit(HomeSuccessDataState());
    })
        .catchError((error) {
          print(error.toString());
          emit(HomeErrorDataState());
    });
  }
}
