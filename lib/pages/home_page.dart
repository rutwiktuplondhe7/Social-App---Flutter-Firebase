import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_drawer.dart';
import 'package:social_media_app/components/my_list_tile.dart';
import 'package:social_media_app/components/my_post_button.dart';
import 'package:social_media_app/components/my_textfield.dart';
import 'package:social_media_app/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController newPostController = TextEditingController();

  final FirestoreDatabase database = FirestoreDatabase();

  //post msg method
  void postMessage() {
    //only post a msg if the textfield is not empty
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    //clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'W A L L',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          //textfield
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                    controller: newPostController,
                    hinttext: "Say Something",
                    obst: false,
                  ),
                ),

                //post button
                MyPostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),

          //posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              //show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              //get all posts
              final posts = snapshot.data!.docs;

              //no data
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text('No Posts.. Post something !'),
                  ),
                );
              }

              //return as a list
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    //get each individual posts
                    final post = posts[index];

                    //get data from each post
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['TimeStamp'];

                    //return as a list tile
                    return MyListTile(title: message, subtitle: userEmail);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
