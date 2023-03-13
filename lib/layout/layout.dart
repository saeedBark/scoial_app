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
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.currentIndex],
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notification_important_outlined)),
              IconButton(onPressed: (){}, icon: Icon(Icons.search)),
            ],
            // backgroundColor: Colors.white,
            // elevation: 0,
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavgatebar,
            onTap: (int index) {
              cubit.changeBottom(index);
            },
          ),
        );
      },
    );
  }
}
