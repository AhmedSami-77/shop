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
class ChangeFavoritesSuccessDataState extends HomeState {}
class ChangeSuccessDataState extends HomeState {}
class ChangeFavoritesErrorDataState extends HomeState {}
