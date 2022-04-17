import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_forest/main.dart';

import '../reusable_widgets/reusable_wiget.dart';
import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({ Key? key }) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor(background_color_array[0]),
              hexStringToColor(background_color_array[1]),
              hexStringToColor(background_color_array[2])
            ], 
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter
          )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                FormTextBox(
                  labelText: "Enter User Name", 
                  icon: Icons.person_outline, 
                  isUserName: true, 
                  isPasswordType: false, 
                  controller: _userNameTextController
                ),
                const SizedBox(
                  height: 20,
                ),

                FormTextBox(
                  labelText: "Enter Email", 
                  icon: Icons.email_rounded,
                  isUserName: false, 
                  isPasswordType: false, 
                  controller: _emailTextController
                ),
                const SizedBox(
                  height: 20,
                ),

                FormTextBox(
                  labelText: "Enter Password", 
                  icon: Icons.lock_outlined, 
                  isUserName: false, 
                  isPasswordType: true,
                  controller: _passwordTextController
                ),
                const SizedBox(
                  height: 20,
                ),

                FormTextBox(
                  labelText: "Confirm Password", 
                  icon: Icons.lock_outlined, 
                  isUserName: false, 
                  isPasswordType: true, 
                  controller: _confirmPasswordTextController
                ),
                const SizedBox(
                  height: 20,
                ),

                firebaseButton(context, "Sign Up", () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailTextController.text, 
                        password: _passwordTextController.text
                  ).then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      )
                    );
                  }).onError((error, stackTrace) {
                    print("Error: ${error.toString()}");
                  });
                })
              ],
            ),
          )
        )
      ),
    );
  } 
}
