import '../data/cache_helper.dart';

void initApp({required bool onBoarding, required String token}) async {

  await CacheHelper.getData(key: 'onBoarding').then((value) {
    onBoarding = value ?? false;
  });
  await CacheHelper.getData(key: 'token').then((value) {
    token = value ?? '';
  });
}

bool getOnBoardingShared() {
  bool onBoarding = false;

    CacheHelper.getData(key: 'onBoarding').then((value) {
      onBoarding = value;
    });


  return onBoarding;
}
String getTokenShared() {
  String token = '';

    CacheHelper.getData(key: 'token').then((value) {
      token = value;
    });


  return token;
}
// signOut(){
// CacheHelper.remove(key: 'token').then((value) {
// if(value){
// Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>LoginScreen()) );
// }
// });
// }
