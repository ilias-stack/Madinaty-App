import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madinaty/usermanager.dart';

// ignore: must_be_immutable
class SignalePage extends StatelessWidget {
  SignalePage({Key? key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();
  CollectionReference signales =
      FirebaseFirestore.instance.collection('contact');
  bool sent = false;
  bool once = false;

  @override
  Widget build(BuildContext context) {
    Map? informs;
    if (MyUsers.islogged() && !MyUsers.isanonyme()) {
      FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: MyUsers.infos()['email'])
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          informs = {
            'nom': value.docs[0].data()['nom'],
            'email': value.docs[0].data()['email'],
            'tele': value.docs[0].data()['telephone'],
            'password': value.docs[0].data()['password']
          };
          name.text = informs!['nom'];
          email.text = informs!['email'];
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            )),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (email.text == '' || name.text == '' || message.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Remplissez tout les champs"),
                    duration: Duration(seconds: 2),
                  ));
                } else if (!(email.text.contains('@') &&
                    email.text.contains('.com'))) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Email invalid"),
                    duration: Duration(seconds: 2),
                  ));
                } else if (!sent) {
                  sent = true;
                  signales.add({
                    'nom': name.text.toString().trim(),
                    'email': email.text.toString().trim(),
                    'message': message.text.toString()
                  }).then((value) {
                    sent = true;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Merci"),
                      duration: Duration(seconds: 1),
                    ));
                    Timer(const Duration(seconds: 2), () {
                      if (!once) {
                        Navigator.of(context).pop();
                        once = true;
                      }
                    });
                  }).catchError((error) {
                    sent = false;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Veuillez réessayer"),
                      duration: Duration(seconds: 2),
                    ));
                  });
                }
              },
              icon: const Icon(
                Icons.send,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
        title: const Image(
            image: AssetImage('assets/Logo-modified.png'),
            width: 40,
            height: 40),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.05,
            child: Image(
                image: const AssetImage('assets/Logo.jpg'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Center(
                    child: Text(
                  'Contactez-nous',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: name,
                    keyboardType: TextInputType.name,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      focusColor: Color.fromRGBO(8, 103, 97, 1),
                      prefixIcon: Icon(Icons.person),
                      label: Text('Nom Complet'),
                      hoverColor: Color.fromRGBO(8, 103, 97, 1),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20))),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width / 1.2,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      focusColor: Color.fromRGBO(8, 103, 97, 1),
                      prefixIcon: Icon(Icons.email),
                      label: Text('Email'),
                      hoverColor: Color.fromRGBO(8, 103, 97, 1),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20))),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width / 1.2,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: message,
                    maxLines: 10,
                    maxLength: 1000,
                    decoration: const InputDecoration(
                      focusColor: Color.fromRGBO(8, 103, 97, 1),
                      hintText: 'Message',
                      hoverColor: Color.fromRGBO(8, 103, 97, 1),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20))),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width / 1.2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
