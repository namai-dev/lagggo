import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lago/auth/authservice.dart';
import 'package:lago/mainpage.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({Key? key}) : super(key: key);

  @override
  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    // Check if a user is currently signed in
    if (_authService.getCurrentUser() != null) {
      // Navigate to Mainpage if the user is already signed in
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Mainpage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            _companyLogo(),
            SizedBox(height: 20.0),
            _welcomeMessage(),
            SizedBox(height: 40.0),
            _phoneNumberSignIn(),
            SizedBox(height: 20.0),
            _googleSignIn(),
            SizedBox(height: 20.0),
            _emailSignIn(),
            Spacer(flex: 2),
            _footerMessage(),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _companyLogo() {
    return Column(
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent.withOpacity(0.2),
          ),
          child: Icon(
            Icons.lock,
            size: 60,
            color: Colors.blueAccent,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Laggo',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ],
    );
  }

  Widget _welcomeMessage() {
    return Text(
      'Welcome! Please sign in to continue.',
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _googleSignIn() {
    return GestureDetector(
      onTap: () async {
        try {
          await _authService.signInWithGoogle();
          if (_authService.getCurrentUser() != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Mainpage()),
            );
          }
        } catch (e) {
          print("Error during Google Sign-In: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to sign in with Google.'),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.google, color: Colors.red),
            SizedBox(width: 10.0),
            Text(
              "Continue with Google",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _phoneNumberSignIn() {
    return GestureDetector(
      onTap: () {
        // Implement phone number sign-in functionality
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.phone, color: Colors.green),
            SizedBox(width: 10.0),
            Text(
              "Continue with Phone Number",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailSignIn() {
    return GestureDetector(
      onTap: () {
        // Implement email sign-in functionality
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.envelope, color: Colors.blue),
            SizedBox(width: 10.0),
            Text(
              "Continue with Email",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _footerMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'By continuing, you agree to our Terms and Conditions',
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
