// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madinaty/Secondary%20Pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nom = TextEditingController();

  TextEditingController tele = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController passw = TextEditingController();

  TextEditingController confpassw = TextEditingController();

  bool once = false;
  bool Isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromRGBO(190, 213, 150, 1),
                Color.fromRGBO(70, 160, 150, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          !Isloading
              ? Center(
                  child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Créer un compte',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextFormField(
                          controller: nom,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'Nom Complet',
                              focusColor: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextFormField(
                          controller: tele,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'Téléphone',
                              focusColor: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'Email',
                              focusColor: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextFormField(
                          controller: passw,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'Mot de passe',
                              focusColor: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextFormField(
                          controller: confpassw,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'Confirmer mot de passe',
                              focusColor: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: RaisedButton(
                          onPressed: () async {
                            if (email.text != "" &&
                                passw.text != "" &&
                                nom.text != "") {
                              if (passw.text.toString() !=
                                  confpassw.text.toString()) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("Confirmer votre mot de passe!!"),
                                  duration: Duration(milliseconds: 500),
                                ));
                              } else {
                                try {
                                  if (!once) {
                                    setState(() {
                                      Isloading = !Isloading;
                                    });
                                    once = true;
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: email.text.trim(),
                                            password: passw.text)
                                        .then((value) => {
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .add({
                                                    'nom': nom.text.trim(),
                                                    'telephone': tele.text,
                                                    'email': email.text.trim(),
                                                    'password': passw.text
                                                  })
                                                  .then((value) => {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Compte créé"),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                        ))
                                                      })
                                                  .then((value) {
                                                    Timer(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      FirebaseAuth.instance
                                                          .signOut()
                                                          .then((value) {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const LoginPage()));
                                                      });
                                                    });
                                                  })
                                            });
                                  }
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    Isloading = !Isloading;
                                  });
                                  once = false;
                                  if (e.code == 'weak-password') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Mot de passe très court"),
                                      duration: Duration(milliseconds: 500),
                                    ));
                                  } else if (e.code == 'email-already-in-use') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Email utilisé"),
                                      duration: Duration(milliseconds: 500),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Erreur"),
                                      duration: Duration(milliseconds: 500),
                                    ));
                                  }
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text("Des champs obligatoires sont vides"),
                                duration: Duration(milliseconds: 700),
                              ));
                            }
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: const Text(
                            "Créer",
                            style: TextStyle(
                                color: Color.fromRGBO(70, 160, 150, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ))
              : const Center(
                  child: SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                )
        ]),
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.login,
                      color: Colors.white,
                      size: 14,
                    ),
                    Text(
                      ' Se Connecter',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ))
          ],
          elevation: 0,
          leading: IconButton(
              iconSize: 25,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(190, 213, 150, 1),
          title: const Image(
              image: AssetImage('assets/LOGO_M.png'), width: 40, height: 40),
        ));
  }
}
