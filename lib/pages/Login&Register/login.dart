import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bhc_prop/core/colors.dart';
import 'package:bhc_prop/core/space.dart';
import 'package:bhc_prop/core/text_style.dart';
import 'package:bhc_prop/pages/Guestpage/home/homepage.dart';
import 'package:bhc_prop/pages/Login&Register/signup.dart';
import 'package:bhc_prop/pages/buyers/home.dart';
import 'package:bhc_prop/pages/tenant/homepage.dart';
import 'package:bhc_prop/widget/main_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  bool _passwordVisible = false; // State variable to toggle password visibility

  // Function to sign in with email and password
  Future<void> signInWithEmailAndPassword() async {
    String email = userName.text.trim();
    String password = userPass.text.trim();

    try {
      // Sign in user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Retrieve user's UID
      String uid = userCredential.user!.uid;

      // Fetch user document from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      // Extract role from user document
      String role = userDoc.get('role');

      // Navigate based on roles
      if (role == 'tenant') {
        // Navigate to tenant page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      } else if (role == 'buyer') {
        // Navigate to buyer page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePageBuyer()),
        );
      } else {
        // Handle unknown role or no role scenario
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Invalid role or user not authorized.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error signing in: $e');
      // Handle sign-in errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to sign in. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SpaceVH(height: 50.0),
              Text(
                'Welcome Back!',
                style: headline1,
              ),
              SpaceVH(height: 10.0),
              Text(
                'Please sign in to your account',
                style: headline3,
              ),
              SpaceVH(height: 60.0),
              // Custom Username TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: userName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SpaceVH(height: 20.0),
              // Custom Password TextField with visibility toggle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: userPass,
                  obscureText: !_passwordVisible, // This controls the password visibility
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SpaceVH(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: headline3,
                    ),
                  ),
                ),
              ),
              SpaceVH(height: 100.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Mainbutton(
                      onTap: signInWithEmailAndPassword,
                      text: 'Sign in',
                      btnColor: bhcyelow,
                    ),
                    SpaceVH(height: 20.0),
                    Mainbutton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const HomePage(),
                          ),
                        );
                      },
                      text: 'Continue as Guest',
                      btnColor: bhcred,
                      txtColor: blackBG,
                    ),
                    SpaceVH(height: 20.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => SignUpPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              style: headline1.copyWith(fontSize: 14.0),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: headlineDot.copyWith(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
