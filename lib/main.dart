import 'package:demoshopapp/controllers/home_cubit.dart';
import 'package:demoshopapp/data/cache_helper.dart';
import 'package:demoshopapp/screens/home_screen.dart';
import 'package:demoshopapp/screens/login_screen.dart';
import 'package:demoshopapp/screens/on_boarding_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'core/variabls.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.initSharedPref();
  await CacheHelper.getData(key: 'onBoarding').then((value) {
    vonBoarding = value ?? false;
  });
  await CacheHelper.getData(key: 'token').then((value) {
    vToken = value ?? '';
  });
  runApp(MyApp(
    onBoarding: vonBoarding,
    token: vToken,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.onBoarding, required this.token});

  final bool onBoarding;

  final String token;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData()..getCategoriesData(),
      child: MaterialApp(
        title: 'Shopping',
        theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.purple,

          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 0,

            selectedItemColor: Colors.purple,
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: onBoarding
            ? token == ''
                ? LoginScreen()
                : const HomeScreen()
            : const OnBoardingScreen(),
      ),
    );
  }
}
