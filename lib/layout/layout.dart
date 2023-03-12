import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/componets/componets.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/remote/sharedPreference/shared_preference.dart';
import 'package:social_app/screen/login/login_screen.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News Feed',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: ConditionalBuilder(
            condition: cubit != null,
            builder: (context) => Column(
              children: [
                if(!FirebaseAuth.instance.currentUser.emailVerified)
                Container(
                  height: 50,
                  color: Colors.amber.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline),
                        SizedBox(
                          width: 20,
                        ),
                        Text('please verify your email '),
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.currentUser.sendEmailVerification().then((value){
                                Fluttertoast.showToast(
                                    msg: 'check email',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }).catchError((error){
                                print(error.toString());
                              });
                            },
                            child: Text(
                              'SEND',
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
