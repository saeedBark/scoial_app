import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/model/user_model.dart';

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
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => builderItem(cubit.users[index]),
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: cubit.users.length,
          ),
          fallback:(context) => Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

  Widget builderItem(UserModel model) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children:  [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    model.image),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                model.name,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      );
}
