import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madinaty/Main%20Pages/reclamation.dart';
import 'package:madinaty/Main%20Pages/services.dart';
import 'package:madinaty/Secondary%20Pages/exemple.dart';
import 'package:madinaty/Secondary%20Pages/loginpage.dart';
import 'package:madinaty/Secondary%20Pages/signaler.dart';
import 'package:madinaty/usermanager.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text('  Actualités',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
            Container(
                margin: const EdgeInsets.only(top: 14, left: 70),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const ExemplePage()));
                      },
                      child: const Text('Derniers reclamations >',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ),
                  ],
                )),
          ],
        ),
        const SizedBox(
          height: 70,
        ),
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Améliorer le paysage urbain',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: const Text(
                    "Signaler les violations de l'excavation des rues, de l'hygiène, des barrières d'excavation, des poteaux d'éclairage et des trottoirs délabrés",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                      ),
                      height: 100,
                      width: 130,
                      child: const Opacity(
                        opacity: 0.37,
                        child: Image(
                          image: AssetImage('Icons/One.jpg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 120, top: 30),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const ServicePage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: const Text(
                            'Réclamer',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(5, 111, 109, 1)),
                          )),
                    )
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 7), // changes position of shadow
                )
              ],
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(120, 183, 72, 1),
                Color.fromRGBO(133, 195, 84, 0.98),
              ]),
              borderRadius: BorderRadius.circular(5),
            ),
            height: 200,
            width: MediaQuery.of(context).size.width / 1.1,
          ),
        ),
        const SizedBox(
          height: 37,
        ),
        Center(
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        height: 100,
                        width: 200,
                        child: Image(
                          image: AssetImage('Icons/Two.jpg'),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                        ),
                        padding: const EdgeInsets.only(right: 10),
                        child: const Text(
                          'Nos Services',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 21),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    '  Choisir un Service :',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: Image(
                                  image: AssetImage('Icons/poubelles.jpg'),
                                ),
                              ),
                              Text('Poubelles')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: const [
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: Image(
                                  image: AssetImage('Icons/trou.jpg'),
                                ),
                              ),
                              Text('Troues')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: Image(
                                  image: AssetImage('Icons/allumer.jpg'),
                                ),
                              ),
                              Text('Éclairage')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              width: MediaQuery.of(context).size.width / 1.1,
              height: 300,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 7), // changes position of shadow
                  )
                ],
                color: const Color.fromRGBO(245, 254, 253, 1),
                borderRadius: BorderRadius.circular(5),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Image(
                        image: AssetImage('Icons/contactus.jpg'),
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'Espace Client',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(
                        'Espace client permet à nos utilisateures de se connecter et sauvegarder leurs session ainsi que suivre les états de leurs réclamations',
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const ReclamationPage(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: const Text(
                        'Accéder',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(5, 111, 109, 1)),
                      ))
                ],
              ),
              width: MediaQuery.of(context).size.width / 1.1,
              height: 270,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 7), // changes position of shadow
                  )
                ],
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(5),
              )),
        ),
        const SizedBox(
          height: 35,
        ),
        Center(
            child: Container(
          child: Column(
            children: [
              const Text(
                'Exprimez-Vous',
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
              const Text('Votre avis nous est important',
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.white)),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: const Opacity(
                      opacity: 0.5,
                      child: Image(
                        image: AssetImage('Icons/Three.jpg'),
                        width: 170,
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10, top: 14),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignalePage()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            child: const Text(
                              'Messager',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(5, 111, 109, 1)),
                            ),
                          )))
                ],
              )
            ],
          ),
          width: MediaQuery.of(context).size.width / 1.1,
          height: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 7), // changes position of shadow
              )
            ],
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(8, 103, 97, 1),
              Color.fromRGBO(44, 129, 96, 1)
            ]),
          ),
        )),
        const SizedBox(
          height: 35,
        )
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
                    onPressed: () {},
                    icon: const Icon(Icons.home,
                        color: Color.fromRGBO(5, 111, 109, 1)))),
            BottomNavigationBarItem(
                label: 'Réclamations',
                icon: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const ReclamationPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.library_books,
                    color: Colors.grey,
                  ),
                )),
          ],
        ),
      ),
      body: const HomePageContent(),
      drawer: const DrawerContent(),
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () {
                    if (MyUsers.islogged() && !MyUsers.isanonyme()) {
                      print('redirected');
                    }
                  }),
              MyUsers.islogged() && !MyUsers.isanonyme()
                  ? Positioned(
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 250, 155, 100),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 10,
                        width: 10,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          )
        ],
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

class DrawerContent extends StatefulWidget {
  const DrawerContent({Key? key}) : super(key: key);

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                      style: TextStyle(color: Colors.blueGrey))
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignalePage()));
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
                    leading: const Icon(Icons.logout),
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
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
