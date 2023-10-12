import 'package:final_project/views/userProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/views/forgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:final_project/views/signUpPage.dart';

class SigninPage extends StatefulWidget {
  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _error = "";
  String _message = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sdfsdfs sd',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Login to Library',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                    color: Colors.black
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()));
                  },
                  child: const Text('Create Account',
                      style: TextStyle(color: Colors.blue, fontSize: 20)),
                ),
                const SizedBox(height: 30),
                Form(
                  key: formKey2,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (input) {
                          if (input!.contains('@gmail.com')) {
                            return null;
                          }
                          return 'Please Enter a Valid Gmail';
                        },
                        onChanged: (value) => _email = value,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        ///  password
                        validator: (input) {
                          if (input!.length < 6) {
                            return 'Your Password should fit atleast 6 Char';
                          }
                          return null;
                        },
                        obscureText: true,
                        onChanged: (value) => _password = value,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Enter Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(_message),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => const ForgotPassword()));
                  },
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: Colors.blue)),
                ),
                const SizedBox(height: 40),
                FloatingActionButton.extended(
                  onPressed: () async {
                    /// Sign in button
                    //FirebaseAuth.instance.signOut();
                    if (formKey2.currentState!.validate()) {
                      try {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _email.trim(), password: _password.trim());
                      } on FirebaseAuthException catch (e) {
                        _error = e.message!;
                      }
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        print('user signed in!');
                        //FirebaseAuth.instance.currentUser!.updateEmail();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfile()));
                      }
                    }
                    setState(() {
                      _message = _error;
                    });
                  },
                  label: const Text('Sign In'),
                  icon: const Icon(Icons.arrow_forward),
                ),
                const SizedBox(height: 20),
                FloatingActionButton.extended(
                  icon: Image.asset(
                    'assets/google.png',
                    height: 30,
                    width: 30,
                  ),
                  onPressed: null,
                  label: const Text(
                    'Sign in with Google',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
