import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madinaty/Main%20Pages/services.dart';
import 'package:madinaty/Secondary%20Pages/loginpage.dart';
import 'package:madinaty/usermanager.dart';

import '../Secondary Pages/signaler.dart';
import '../datamodel.dart';
import 'homepage.dart';

class ReclamationPage extends StatefulWidget {
  const ReclamationPage({Key? key}) : super(key: key);

  @override
  State<ReclamationPage> createState() => _ReclamationPageState();
}

class _ReclamationPageState extends State<ReclamationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          selectedFontSize: 12,
          selectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                label: 'Services',
                icon: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const ServicePage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.miscellaneous_services_outlined,
                  ),
                )),
            BottomNavigationBarItem(
                label: ('Home'),
                icon: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const HomePage(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.home,
                    ))),
            BottomNavigationBarItem(
                label: 'Réclamations',
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.library_books,
                    color: Color.fromRGBO(5, 111, 109, 1),
                  ),
                )),
          ],
        ),
      ),
      body: !MyUsers.islogged()
          ? Center(
              child: Stack(
              children: [
                Container(
                  color: const Color.fromRGBO(247, 247, 247, 1),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        const SizedBox(
                          height: 200,
                          width: 170,
                          child:
                              Image(image: AssetImage('Icons/rec_not_con.jpg')),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Suivre vos réclamations',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Pour pouvoir suivre vos réclamations',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54)),
                        const Text('Vous devez vous connecter',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54)),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (ctx) => const LoginPage()))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(3, 99, 98, 1))),
                            child: const Text(
                              "Se connecter",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: 230,
                          child: TextButton(
                            autofocus: true,
                            onPressed: () {
                              FirebaseAuth.instance
                                  .signInAnonymously()
                                  .then((value) {
                                setState(() {});
                              }).catchError((err) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Une erreur a survenu"),
                                  duration: Duration(milliseconds: 300),
                                ));
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(247, 247, 247, 1))),
                            child: const Text(
                              "Réclamation anonyme",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromRGBO(3, 99, 98, 1),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ))
          : MyUsers.isanonyme()
              ? ListView(
                  children: const [
                    SizedBox(
                      height: 70,
                    ),
                    Opacity(
                      opacity: 0.7,
                      child: Image(
                        image: AssetImage('Icons/anonyme.jpg'),
                      ),
                    ),
                    Center(
                        child: Text(
                      'Vous êtes en mode Anonyme',
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    )),
                    SizedBox(
                      height: 12,
                    ),
                    Center(
                        child: Text(
                      'Vous pouvez effectuer des réclamations mais',
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.bold),
                    )),
                    Center(
                        child: Text(
                      'vous ne pouvez pas les suivre',
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.bold),
                    )),
                  ],
                )
              : StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('reclamations')
                      .where('owner', isEqualTo: MyUsers.infos()['email'])
                      .orderBy('date', descending: true)
                      .limit(10)
                      .snapshots(),
                  builder: ((context, snapshot) {
                    List<DataModel> a;
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData ||
                        snapshot.hasError) {
                      return const Center(
                        child: SizedBox(
                            height: 80,
                            width: 80,
                            child: CircularProgressIndicator(
                                color: Color.fromRGBO(70, 160, 150, 1))),
                      );
                    } else {
                      a = snapshot.data!.docs.map((doc) {
                        return DataModel(
                          doc: doc,
                        );
                      }).toList();
                      return ListView(
                          children: a.isEmpty
                              ? const [
                                  SizedBox(
                                    height: 140,
                                  ),
                                  Image(
                                      height: 170,
                                      image: AssetImage('Icons/empety.png')),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child: Text(
                                      'Liste de réclamations vide',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 22),
                                    ),
                                  )
                                ]
                              : a);
                    }
                  })),
      drawer: Drawer(
        child: Scaffold(
          body: ListView(
            padding: const EdgeInsets.only(top: 20, left: 5),
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Fermer',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                              title: const Text('A propos de Madinaty'),
                              content: SizedBox(
                                height: 400,
                                child: Column(
                                  children: const [
                                    Image(
                                      image: AssetImage('assets/Logo.jpg'),
                                      height: 150,
                                      width: 150,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '• Madinaty-App est une application mobile de réclamation de problèmes de la route.',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        '•	Son but en premier degré est l’amélioration de la zone urbain dans le périmétre de la villle d’Essaouira .',
                                        style: TextStyle(color: Colors.grey)),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                        'De façon générale l’amélioration du paysage urbain.',
                                        style:
                                            TextStyle(color: Colors.blueGrey))
                                  ],
                                ),
                              ));
                        });
                  },
                  leading: const Icon(Icons.info),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  title: const Align(
                    child: Text(
                      'A propos de nous     ',
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => SignalePage()))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  leading: const Icon(Icons.help),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  title: const Align(
                    child: Text(
                      'Nous contacter        ',
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
              const Divider(),
              !MyUsers.islogged()
                  ? ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (ctx) => const LoginPage()))
                            .then((value) {
                          setState(() {});
                        });
                      },
                      leading: const Icon(Icons.login),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      title: const Align(
                        child: Text(
                          'Se connecter           ',
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  : ListTile(
                      onTap: () {
                        FirebaseAuth.instance.signOut().then((vrr) {
                          setState(() {});
                          Fluttertoast.showToast(
                              msg: "Vous êtes déconnecté",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      },
                      leading: const Icon(Icons.login),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      title: const Align(
                        child: Text(
                          'Se déconnecter           ',
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
            ],
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.white,
            title: const Text(
              'Autres',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(5, 111, 109, 1),
              Color.fromRGBO(71, 151, 88, 1)
            ],
            stops: [0.5, 1.0],
          )),
        ),
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 6,
            ),
            const Image(
              image: AssetImage('assets/LOGO_M.png'),
              width: 30,
              height: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Madinaty',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
