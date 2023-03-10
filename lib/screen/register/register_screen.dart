import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/componets/componets.dart';
import 'package:social_app/screen/register/cubit/cubit.dart';
import 'package:social_app/screen/register/cubit/state.dart';
import 'package:social_app/style/colors.dart';

class RegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var namedController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
          //  appBar: AppBar(),
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
                            text: 'REGISTER',
                            fontSize: 24,
                            fontWeidght: FontWeight.bold,
                            color: defaultColor),
                        SizedBox(
                          height: 30,
                        ),

                        defaultFormFile(
                          controller: namedController,
                          type: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please you must fill your name here..';
                            }
                            return null;
                          },
                          lable: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormFile(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please you must fill your email here..';
                            }
                            return null;
                          },
                          lable: 'Email',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormFile(
                          controller: passwordController,
                          isPassword: cubit.isPassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please you must fill your password here..';
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
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormFile(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please you must fill your phone here..';
                            }
                            return null;
                          },
                          lable: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: true,
                          // state is! ShopLoginLoadingState,
                          builder: (context) =>
                              defaultButton(
                                fanction: () {
                                  if (formkey.currentState.validate()) {
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                       );
                                 //   print('saeed');
                                    //navigatorAndReplace(context, LayoutScreen());
                                   }
                                },
                                text: 'Register',
                                isUpperCase: true,
                              ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
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
