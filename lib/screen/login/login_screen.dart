import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/componets/componets.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/remote/sharedPreference/shared_preference.dart';
import 'package:social_app/screen/login/cubit/cubit.dart';
import 'package:social_app/screen/login/cubit/state.dart';
import 'package:social_app/screen/register/register_screen.dart';
import 'package:social_app/style/colors.dart';

class LoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is LoginSuccessState) {
            SharedPreferenceCach.saveData(key: 'uId', value: state.uId)
                .then((value) {
              navigatorAndReplace(context, LayoutScreen());
            });
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            //   appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultText(
                          text: 'LOGIN',
                          fontSize: 24,
                          fontWeidght: FontWeight.bold,
                          color: defaultColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultText(
                            text: 'Please entre your email and password ',
                            fontSize: 20,
                            fontWeidght: FontWeight.bold,
                            color: Colors.grey),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormFile(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please you must fill email here..';
                            }
                            return null;
                          },
                          lable: 'Email',
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultFormFile(
                          controller: passwordController,
                          isPassword: cubit.isPassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please you must fill password here..';
                            }
                            return null;
                          },
                          suffix: cubit.suffix,
                          onTap: () {
                            cubit.changPasswordShow();
                          },
                          lable: 'Password',
                          prefix: Icons.password,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            fanction: () {
                              if (formkey.currentState.validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                                //  print('saeed');
                                // navigatorAndReplace(context, LayoutScreen());
                              }
                            },
                            text: 'LOgin',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultText(
                              text: "Don't have alerdy email?",
                            ),
                            TextButton(
                                onPressed: () {
                                  navigatorAndReplace(
                                      context, RegisterScreen());
                                },
                                child: defaultText(
                                    text: 'Register', color: defaultColor)),
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
