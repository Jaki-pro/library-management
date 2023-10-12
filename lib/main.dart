import 'package:final_project/views/signInPage.dart';
import 'package:final_project/views/singleBook.dart';
import 'package:final_project/views/start.dart';
import 'package:final_project/views/userProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    //print('user is signed out');
    runApp(MaterialApp(title: 'SignInPage', home: OnBoardingScreen()));
  } else {
    //print('user is signed in');
    runApp(MaterialApp(title: 'SignInPage', home: UserProfile()));
  }
}
