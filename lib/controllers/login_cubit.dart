import 'package:bloc/bloc.dart';
import 'package:demoshopapp/core/strings.dart';
import 'package:demoshopapp/data/dio.dart';
import 'package:demoshopapp/data/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/cache_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  IconData suffix = Icons.visibility;
  bool isPasswordShown = true;
  late UserModel user;
 static  bool? onBoarding;
  static  String? token;

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
    String? lang,
    String? token,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      endPoint: kLoginEndPoint,
      data: {
        'email': email,
        'password': password,
      },
      lang: lang,
      token: token,
    ).then((value) {
      print(value.data);
      user = UserModel.fromJson(value.data);

      emit(LoginSuccessState(user));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown == true ? Icons.visibility : Icons.visibility_off;

    emit(ShownPasswordState());
  }

 void getOnBoardingShared() {

    CacheHelper.getData(key: 'onBoarding').then((value) {
      onBoarding = value;
    });
    emit(DoneOnBoardingState());


  }

  void getTokenShared() {
    CacheHelper.getData(key: 'token').then((value) {
      token = value;
    });
    emit(DoneLoginState());

  }
}
