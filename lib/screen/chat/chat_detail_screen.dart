import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/style/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  var messageController = TextEditingController();

  ChatDetailsScreen({Key key, this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(userModel.image),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  userModel.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              buildMessage(),
              buildMyMessage(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300], width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              label: Text(
                                'write your message here ....',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        color: defaultColor,
                        child: IconButton(
                          onPressed: () {
                            SocialCubit.get(context).sendMessage(
                              reciveId: userModel.uid,
                              dateTime: DateTime.now().toString(),
                              text: messageController.text,
                            );
                          },
                          icon: const Icon(Icons.send),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildMessage() => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  bottomEnd: Radius.circular(10),
                ),
                color: Colors.grey[300]),
            child: const Text('Hello World '),
          ),
        ),
      );
  Widget buildMyMessage() => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                ),
                color: defaultColor.withOpacity(0.3)),
            child: const Text('Hello World '),
          ),
        ),
      );
}
