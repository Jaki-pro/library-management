import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _name = "";
  String _email = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dsfsf sdfa',
      home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/loginBG.jpeg'), fit:BoxFit.fill)
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset\nPassword',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: [

                        TextFormField( /// Enter Email
                          validator: (input){
                            if(input == null && input!.contains('@gmail.com') ){
                              return 'Please Enter a Valid Gmail';
                            }
                            return null;
                          },
                          onChanged: (value)=> _email=value,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              labelText: 'Enter Your Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:180,),
                    FloatingActionButton.extended(

                      onPressed: () async{
                        await FirebaseAuth.instance.signOut();
                      },
                      label: Text('Send Request'),
                      icon: Icon(Icons.arrow_forward),
                    ),

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
