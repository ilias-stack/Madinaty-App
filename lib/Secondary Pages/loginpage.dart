// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madinaty/Secondary%20Pages/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

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
                        'Se Connecter',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Connectez-vous pour utiliser Madinaty',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const Text(
                        'plus efficacement',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 70,
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
                          controller: pass,
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
                        height: 40,
                      ),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: RaisedButton(
                          onPressed: () async {
                            setState(() {
                              Isloading = !Isloading;
                            });
                            if (!once) {
                              once = true;
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email.text.trim(),
                                      password: pass.text)
                                  .then((value) {
                                Fluttertoast.showToast(
                                    msg: "Vous êtes connecté",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.SNACKBAR,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Timer(const Duration(seconds: 0), () {
                                  Navigator.of(context).pop();
                                });
                              }).catchError((err) {
                                setState(() {
                                  Isloading = !Isloading;
                                });
                                once = false;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Erreur"),
                                  duration: Duration(milliseconds: 1500),
                                ));
                              });
                            }
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: const Text(
                            "Se connecter",
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
                      child: CircularProgressIndicator(color: Colors.white)),
                )
        ]),
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.account_box_sharp,
                      color: Colors.white,
                      size: 14,
                    ),
                    Text(
                      'Créer un compte',
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
