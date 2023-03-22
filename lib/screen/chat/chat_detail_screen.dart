import 'package:flutter/material.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/style/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({this.userModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(userModel.image),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              userModel.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    bottomEnd: Radius.circular(10),

                  ),
                  color: Colors.grey[300]
                ),
                child: Text('Hello World '),),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10),
                      bottomStart: Radius.circular(10),

                    ),
                    color: defaultColor.withOpacity(0.3)
                ),
                child: Text('Hello World '),),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                height: 50,
              decoration: BoxDecoration(
               border: Border.all( color: Colors.grey[300],width: 1),
                borderRadius: BorderRadius.circular(10)

              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          label:Text ('write your message here ....',style: TextStyle(fontSize: 18,color: Colors.grey[600]),),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      color: defaultColor,

                      child: IconButton(onPressed: (){}, icon: Icon(Icons.send),color: Colors.white,),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
