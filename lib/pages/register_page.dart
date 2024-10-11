import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_button.dart';
import 'package:social_media_app/components/my_textfield.dart';
import 'package:social_media_app/helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();

  final _pwController = TextEditingController();

  final _confirmPwController = TextEditingController();

  final _usernameController = TextEditingController();

  void registerUser() async {
    //show loading screen
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //make sure passwords match
    if (_pwController.text != _confirmPwController.text) {
      //pop loading circle
      Navigator.pop(context);

      displayErrorMessage('Password\'s don\'t match !', context);
    } else {
      //register
      try {
        //create user
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _pwController.text,
        );

        //create a user doc
        createUserDocument(userCredential);

        //pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop the loading circle
        Navigator.pop(context);

        //display msg
        displayErrorMessage(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': _usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //icon
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 25),

                //app name
                const Text(
                  'S O C I A L',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 25),

                //username textfield
                MyTextfield(
                  controller: _usernameController,
                  hinttext: 'Username',
                  obst: false,
                ),
                const SizedBox(height: 10),

                //email textfield
                MyTextfield(
                  controller: _emailController,
                  hinttext: 'Email',
                  obst: false,
                ),
                const SizedBox(height: 10),

                //password text field
                MyTextfield(
                  controller: _pwController,
                  hinttext: 'Password',
                  obst: true,
                ),
                const SizedBox(height: 10),

                //confirm password
                MyTextfield(
                  controller: _confirmPwController,
                  hinttext: 'Confirm password',
                  obst: true,
                ),

                const SizedBox(height: 20),

                //sign UP
                MyButton(
                  text: 'Register',
                  onTap: registerUser,
                ),
                const SizedBox(height: 20),

                //register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account ? '),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
