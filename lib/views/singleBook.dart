import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingleBook extends StatefulWidget {
  final int bookNo;
  final int bookCount;
  final String bookName;

  const SingleBook({super.key, required this.bookNo, required this.bookName, required this.bookCount});
  @override
  State<SingleBook> createState() => _SingleBookState();
}

class _SingleBookState extends State<SingleBook> {

  String? userEmail = FirebaseAuth.instance.currentUser!.email;
  String? userName = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Back to Profile', textAlign: TextAlign.center),
          backgroundColor: Colors.green),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 200),
          Container(
            color: Colors.blueGrey,
            height: 40,
            width: double.infinity,
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Book Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25))
                ]),
          ),
          Column(
            children: [
              /// Book Name
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Book Name",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        TextButton(
                            onPressed: null,
                            child: Text(widget.bookName,
                                style: const TextStyle(fontSize: 20)))
                      ])),

              /// Book Writers
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Writer",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        'Hary Tector',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),

              /// Book Category
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        'Philosophy',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        "150 TK",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Available",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Books').doc('${widget.bookNo}').snapshots(),
                      builder: (context, snapshot) {
                        int count = 0;
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          var data = snapshot.data!.data();
                          count = data!['No'];
                          return Text('$count');
                        }
                        return Text('0');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    int count=0;
                    if (widget.bookCount > 0) count = widget.bookCount - 1;
                    print('book no ${widget.bookNo}');
                    await FirebaseFirestore.instance
                        .collection('Books')
                        .doc('${widget.bookNo}')
                        .set({'No': count});
                      // Navigator.push(
                      // context,
                      // MaterialPageRoute(
                      // builder: (context) => SingleBook(
                      // bookNo: widget.bookNo,
                      // bookName: widget.bookName,
                      // bookCount: count,
                      // ),
                      // ));
                    FirebaseFirestore.instance.collection('user').doc(userEmail).update({
                      'bookBorrowed': FieldValue.increment(1),

                    });
                      },

                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, elevation: 0),
                  child: const Text(
                    'Borrow Book',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
