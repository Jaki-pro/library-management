import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/views/start.dart';
import 'package:final_project/views/signInPage.dart';
import 'package:final_project/views/userProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _name = "";
  String _email = "";
  String _password = "";
  String _error = "";
  String _message = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignUp Page',
      home: Container(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create New\n Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SigninPage(),
                        ));
                  },
                  child: Text(
                    'Already Registered? Login',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  /// Form Key
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });

                         // _name = value;

                        },
                        decoration: InputDecoration(
                            hintText: 'Name',
                            labelText: 'Enter Your Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        /// Enter Email
                        validator: (input) {
                          if (input!.contains('@gmail.com')) {
                            return null;
                          }
                          return 'Please Enter a Valid Gmail';
                        },
                        onChanged: (value) => _email = value,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Enter Your Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        /// New password
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
                            labelText: 'Enter a New Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        /// Confirm Password
                        validator: (input) {
                          if (input != _password) {
                            return 'Mismatched previous Password';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(_message),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton.extended(
                  onPressed: () async {
                    //print('given name is $_name');
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _email.trim(),
                                password: _password.trim());
                      } on FirebaseAuthException catch (e) {
                        _error = e.message!;
                      }
                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        print('user signed in!');
                        String? userEmail =
                          await  FirebaseAuth.instance.currentUser!.email;
                       await FirebaseAuth.instance.currentUser!
                            .updateDisplayName('$_name');
                       await FirebaseFirestore.instance.collection('user').doc(userEmail).set({
                          'bookBorrowed': 0,
                        });
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
                  label: Text('Sign Up'),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
