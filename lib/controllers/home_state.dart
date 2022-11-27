part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeChangeBottomNavState extends HomeState {}

class HomeLoadingDataState extends HomeState {}

class HomeSuccessDataState extends HomeState {}

class HomeErrorDataState extends HomeState {}

class CategoriesLoadingDataState extends HomeState {}

class CategoriesSuccessDataState extends HomeState {}

class CategoriesErrorDataState extends HomeState {}

class ChangeFavoritesSuccessDataState extends HomeState {
  final ChangeFavoritesModel model;

  ChangeFavoritesSuccessDataState(this.model);
}

class ChangeSuccessDataState extends HomeState {}

class ChangeFavoritesErrorDataState extends HomeState {}

class FavoritesLoadingDataState extends HomeState {}

class FavoritesSuccessDataState extends HomeState {}

class FavoritesErrorDataState extends HomeState {}

class ProfileLoadingDataState extends HomeState {}

class ProfileSuccessDataState extends HomeState {
  final UserModel userModel;
  ProfileSuccessDataState( this.userModel);
}

class ProfileErrorDataState extends HomeState {}
