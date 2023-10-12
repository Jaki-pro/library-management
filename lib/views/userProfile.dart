import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/views/signInPage.dart';
import 'package:final_project/views/signUpPage.dart';
import 'package:final_project/views/singleBook.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? userEmail = FirebaseAuth.instance.currentUser!.email;
  String? userName = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: Colors.lightGreen,
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Logout"),
                ),
              ];
            }, onSelected: (value) {
              if (value == 1) {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SigninPage()));
              }
            }),
          ],
        ),
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/profile.jpeg'),
                                        radius: 40),
                                    SizedBox(height: 20),
                                    Text(
                                      'Comilla University',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'University',
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(width: 20, height: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '$userName',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25),
                                  ),
                                  Text('$userEmail',
                                      style: const TextStyle(
                                          color: Colors.white60,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(userEmail)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      int count = 0;
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasData) {
                                        var data = snapshot.data!.data();
                                        count = data!['bookBorrowed'];
                                        return Text(
                                          '$count',
                                          style: TextStyle(color: Colors.white),
                                        );
                                      }
                                      return Text(
                                        '0',
                                        style: TextStyle(color: Colors.white),
                                      );
                                    },
                                  ),
                                  const Text('Books You Read',
                                      style: TextStyle(
                                          color: Colors.white60, fontSize: 15)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                height: 1000,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      spreadRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),

                        /// Bokk list headline
                        Container(
                            color: Colors.blueGrey,
                            height: 40,
                            width: double.infinity,
                            child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Book List',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25))
                                ])),
                        Column(
                          children: [
                            /// Book 1
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        spreadRadius: 2)
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Sophe's World",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      int No = 0;
                                      await FirebaseFirestore.instance
                                          .collection('Books')
                                          .doc('1')
                                          .get()
                                          .then((DocumentSnapshot doc) {
                                        final data =
                                            doc.data() as Map<String, dynamic>;
                                        No = data['No'];
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SingleBook(
                                              bookNo: 1,
                                              bookName: "Sophe's World",
                                              bookCount: No,
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// Book 2
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Those Men",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      int No = 0;
                                      await FirebaseFirestore.instance
                                          .collection('Books')
                                          .doc('2')
                                          .get()
                                          .then((DocumentSnapshot doc) {
                                        final data =
                                            doc.data() as Map<String, dynamic>;
                                        No = data['No'];
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SingleBook(
                                              bookNo: 2,
                                              bookName: "Those Men",
                                              bookCount: No,
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// Book 3
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Killer Dog",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Column(children: [
                                    TextButton(
                                      onPressed: () async {
                                        int No = 0;
                                        await FirebaseFirestore.instance
                                            .collection('Books')
                                            .doc('3')
                                            .get()
                                            .then((DocumentSnapshot doc) {
                                          final data = doc.data()
                                              as Map<String, dynamic>;
                                          No = data['No'];
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SingleBook(
                                                bookNo: 3,
                                                bookName: "Killer Dog",
                                                bookCount: No,
                                              ),
                                            ));
                                      },
                                      child: Text(
                                        'View',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),



                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
