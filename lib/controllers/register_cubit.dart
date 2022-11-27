import 'package:bloc/bloc.dart';
import 'package:demoshopapp/controllers/register_state.dart';
import 'package:demoshopapp/core/strings.dart';
import 'package:demoshopapp/data/dio.dart';
import 'package:demoshopapp/data/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/variabls.dart';
import '../data/cache_helper.dart';



class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  IconData suffix = Icons.visibility;
  bool isPasswordShown = true;
  late UserModel user;
  static  bool? onBoarding;
  static  String? token;

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? lang,
    String? token,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      endPoint: kRegisterEndPoint,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
      lang: lang,
      token: token,
    ).then((value) {
        print(value.data);
      user = UserModel.fromJson(value.data);
        vToken=user.data.token;
      emit(RegisterSuccessState(user));

    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown == true ? Icons.visibility : Icons.visibility_off;

    emit(RegisterShownPasswordState());
  }

  void getTokenShared() {
    CacheHelper.getData(key: 'token').then((value) {
      vToken = value;
    });
    emit(RegisterDoneLoginState());

  }
}
