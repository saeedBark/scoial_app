

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/screen/chat/chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users.length > 0,
          builder:(context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => builderItem(cubit.users[index],context),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: cubit.users.length,
          ),
          fallback:(context) => const Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

  Widget builderItem(UserModel model,context) => InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDetailsScreen(
            userModel: model,
          )));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children:  [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                   '${ model.image}'),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                '${model.name}',
                style: const TextStyle(
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      );
}
