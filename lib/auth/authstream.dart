import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lago/mainpage.dart';
import 'package:lago/pages/login_signup.dart';

class AuthStream extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // User is signed in, navigate to HomePage
          return Mainpage();
        } else {
          // User is not signed in, navigate to LoginSignup page
          return LoginSignup();
        }
      },
    );
  }
}
