import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //header
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  size: 30,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              //home
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const ListTile(
                    leading: Icon(Icons.home),
                    title: Text('H O M E'),
                  ),
                ),
              ),

              //PROFILE
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile_page');
                  },
                  child: const ListTile(
                    leading: Icon(Icons.person),
                    title: Text('P R O F I L E'),
                  ),
                ),
              ),

              //USERS
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/users_page');
                  },
                  child: const ListTile(
                    leading: Icon(Icons.group),
                    title: Text('U S E R S'),
                  ),
                ),
              ),
            ],
          ),

          //LOGOUT
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: GestureDetector(
              onTap: () => FirebaseAuth.instance.signOut(),
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text('L O G O U T'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
