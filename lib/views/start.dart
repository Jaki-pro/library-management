import 'package:final_project/views/signInPage.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold( 
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Welcome To Digital Library!',
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 25,
                  fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Image.asset('assets/home.jpeg'),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    spreadRadius: 2,
                  )
                ],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight:Radius.circular(16)),

              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Enhance Your Knowledge By Reading Books',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      ' ARE YOU READY TO ENJOY WONDERFUL BOOKS :)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueGrey
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SigninPage()));
                    },
                    minWidth: double.infinity,
                    color: Colors.white,
                    elevation: 3,
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500
                      ),
                    ),

                  )

                ],
              ),
            )

          ],
        ),
      )
    ));
  }
}
