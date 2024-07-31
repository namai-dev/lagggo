import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream to listen to authentication state changes
  Stream<User?> get userChanges => _auth.authStateChanges();

  // Method to sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Save user information if not yet saved
      await _saveUserToFirestore(userCredential.user);

      return userCredential;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  Future<void> _saveUserToFirestore(User? user) async {
    if (user == null) return;

    final userRef = _firestore.collection('users').doc(user.uid);
    final doc = await userRef.get();

    if (!doc.exists) {
      await userRef.set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("User saved to Firestore.");
    } else {
      print("User already exists in Firestore.");
    }
  }

  Future<void> getFirebaseIdToken() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        IdTokenResult tn = await user.getIdTokenResult();
        String idToken = tn.token!;
        debugPrint('ID Token: $idToken', wrapWidth: 1024);

        // Define your API endpoint URL
        final url =
            'http://192.168.43.41:3000/api/v1/hello'; // Use the correct IP address

        // Send the token in the Authorization header
        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        );
        print(response);

        // Print the response body
        if (response.statusCode == 200) {
          print('Response data: ${response.body}');
        } else {
          print('Failed to load data. Status code: ${response.statusCode}');
        }
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print("Error getting Firebase ID token or sending request: $e");
    }
  }

  // Method to sign out
  Future<void> signOut() async {
    getFirebaseIdToken();
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Method to get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
