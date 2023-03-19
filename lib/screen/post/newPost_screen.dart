import 'package:flutter/material.dart';
import 'package:social_app/componets/componets.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarr(
          title: 'Creat Post',
          action: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Post',
                  style: TextStyle(fontSize: 20),
                ))
          ],
          context: context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://www.sayidaty.net/sites/default/files/styles/600x380/public/2023-03/222113.jpg?h=ea95bb15'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Saeed bark',
                        style: TextStyle(height: 1.3, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'What is on your mind .......',
                    border: InputBorder.none),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text('add photo'),
                        ],
                      )),
                ),
                Expanded(
                    child: TextButton(onPressed: () {}, child: Text('# tags')))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
