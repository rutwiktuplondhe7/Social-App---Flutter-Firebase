import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/auth/login_or_register.dart';

import '../pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if user is logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          //if not logged in then display login or register page
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
