import 'package:demoshopapp/controllers/login_cubit.dart';
import 'package:demoshopapp/data/cache_helper.dart';
import 'package:demoshopapp/screens/home_screen.dart';
import 'package:demoshopapp/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.user.status) {
            Fluttertoast.showToast(
                msg: state.user.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            CacheHelper.saveData(key: 'token', value: state.user.data.token)
                .then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
              );
            });
          } else {
            Fluttertoast.showToast(
              msg: state.user.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 33),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'login now to browse our hot offers',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (val) {
                          if (val!.isEmpty) return 'please enter an email';
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          label: Text('Email'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (val) {
                          if (val!.isEmpty) return 'please enter an password';
                          return null;
                        },
                        obscureText: LoginCubit.get(context).isPasswordShown,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          label: const Text('password'),
                          suffixIcon: IconButton(
                            icon: Icon(LoginCubit.get(context).suffix),
                            onPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (val) {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                                lang: 'en');
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: state is! LoginLoadingState
                            ? ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        lang: 'en');
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account ?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => RegisterScreen()));
                            },
                            child: const Text('REGISTER'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
);
  }
}
