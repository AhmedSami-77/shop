import 'package:demoshopapp/controllers/register_cubit.dart';
import 'package:demoshopapp/controllers/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../data/cache_helper.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
  create: (context) => RegisterCubit(),
  child: BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if (state is RegisterSuccessState) {
      if (state.user.status) {
        Fluttertoast.showToast(
            msg: state.user.message ?? '',
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
          msg: state.user.message ?? '',
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
                    'REGISTER',
                    style: TextStyle(fontSize: 33),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'REGISTER now to browse our hot offers',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (val) {
                      if (val!.isEmpty) return 'please enter an user name';
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      label: Text('user name'),
                      border: OutlineInputBorder(),
                    ),
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
                      label: Text('email'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (val) {
                      if (val!.isEmpty) return 'please enter a password';
                      return null;
                    },
                    obscureText: RegisterCubit.get(context).isPasswordShown,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      label: const Text('password'),
                      suffixIcon: IconButton(
                        icon: Icon(RegisterCubit.get(context).suffix),
                        onPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: phoneController,
                    validator: (val) {
                      if (val!.isEmpty) return 'please enter a phone';
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      label: Text('phone'),
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (val) {
                      if (formKey.currentState!.validate()) {
                        RegisterCubit.get(context).userRegister(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            lang: 'en');
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: state is! RegisterLoadingState
                        ? ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  lang: 'en',
                                );
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'REGISTER',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),
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
