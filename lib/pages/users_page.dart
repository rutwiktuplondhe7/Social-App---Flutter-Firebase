import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_list_tile.dart';
import 'package:social_media_app/helper/helper_function.dart';

import '../components/my_back_button.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
        stream: firestore.collection('Users').snapshots(),
        builder: (context, snapshot) {
          //any errors
          if (snapshot.hasError) {
            displayErrorMessage('Something went wrong', context);
          }

          //show loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Text("No Data");
          }

          final users = snapshot.data!.docs;

          return Column(
            children: [
              //back button
              const Padding(
                padding: const EdgeInsets.only(top: 40, left: 25),
                child: Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    //get individual user
                    final user = users[index];

                    //get data from each user
                    String username = user['username'];
                    String email = user['email'];

                    return MyListTile(title: username, subtitle: email);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
