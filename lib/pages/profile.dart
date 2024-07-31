import 'package:flutter/material.dart';

import 'package:lago/auth/authservice.dart';
import 'package:lago/pages/login_signup.dart';

class Profile extends StatefulWidget {
  final AuthService authService = AuthService();

  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Function to handle sign-out
  Future<void> _handleSignOut() async {
    try {
      await widget.authService.signOut();
      // Navigate to login page or show a confirmation message
      // For example, using Navigator to go back to login screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginSignup()),
      );
    } catch (e) {
      // Handle error, show a snackbar or dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing out. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: <Widget>[
          // Add any other widgets here, like profile information
          Expanded(
            child: Center(
              child: Text(
                'Profile Information',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await widget.authService.getFirebaseIdToken();
            },
            child: Text("Get Token"),
          ),
          // Spacer to push the sign-out button to the bottom
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _handleSignOut,
              child: Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
