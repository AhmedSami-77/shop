part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  final UserModel user;
  LoginSuccessState(this.user);
}
class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}
class ShownPasswordState extends LoginState{}
class DoneOnBoardingState extends LoginState{}
class DoneLoginState extends LoginState{}