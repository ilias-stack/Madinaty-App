import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madinaty/Main%20Pages/reclamation.dart';
import 'package:madinaty/Secondary%20Pages/reclamer.dart';
import 'package:madinaty/usermanager.dart';
import '../Secondary Pages/loginpage.dart';
import 'homepage.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  var searchi = const Icon(Icons.search);

  bool openned = false;
  var servs = [
    'Poubelles',
    'Troues',
    'Luminosité',
    'Barrières',
    'Trottoires',
    'Panneaux',
    'Accidents',
    'Routières',
    'Graffiti',
    'Travaux',
    'Autres'
  ];

  Map<String, String> servsnums = {
    'Poubelles': '1',
    'Troues': '2',
    'Luminosité': '3',
    'Barrières': '4',
    'Trottoires': '5',
    'Panneaux': '6',
    'Accidents': '7',
    'Routières': '8',
    "Graffiti": '9',
    "Travaux": '10',
    "Autres": '11'
  };
  bool cond = true;
  TextEditingController rech = TextEditingController();

  List<String> finder(String a) {
    List<String> resp = [];
    for (int i = 0; i < servs.length; i++) {
      if (servs[i].toUpperCase().contains(a.toUpperCase())) resp.add(servs[i]);
    }
    if (!resp.contains('Autres')) resp.add(servs[servs.length - 1]);
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    Widget logo;
    if (!openned) {
      logo = const Text(
        'Madinaty',
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    } else {
      logo = SizedBox(
        width: 140,
        height: 40,
        child: TextField(
          controller: rech,
          textAlignVertical: TextAlignVertical.bottom,
          onChanged: (text) {
            setState(() {});
          },
          style: const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            hintText: 'Chercher...',
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            filled: true,
            hoverColor: Color.fromRGBO(8, 103, 97, 1),
            fillColor: Colors.white60,
          ),
        ),
      );
    }

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
                  onPressed: () {},
                  icon: const Icon(Icons.miscellaneous_services_outlined,
                      color: Color.fromRGBO(5, 111, 109, 1)),
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
      body: GridView.builder(
        itemCount: finder(rech.text).length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (!MyUsers.islogged()) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Column(
                            children: const [
                              Text('Vous n\'êtes pas connecté',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 14, 39, 24))),
                            ],
                          ),
                          actions: <Widget>[
                            Center(
                              child: Row(
                                children: [
                                  const SizedBox(width: 30),
                                  SizedBox(
                                    height: 35,
                                    width: 100,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const LoginPage()))
                                            .then((value) {
                                          if (MyUsers.islogged()) {
                                            Navigator.of(context).pop();
                                          }
                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromRGBO(
                                                      3, 99, 98, 1))),
                                      child: const Text(
                                        "Se connecter",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 35,
                                    width: 100,
                                    child: TextButton(
                                      autofocus: true,
                                      onPressed: () {
                                        FirebaseAuth.instance
                                            .signInAnonymously()
                                            .then((value) {
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Vous êtes en mode anonyme"),
                                            duration:
                                                Duration(milliseconds: 1300),
                                          ));
                                        }).catchError((err) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content:
                                                Text("Une erreur a survenu"),
                                            duration:
                                                Duration(milliseconds: 300),
                                          ));
                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromRGBO(
                                                      255, 255, 255, 1))),
                                      child: const Text(
                                        "Anonyme",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color.fromRGBO(3, 99, 98, 1),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Reclamer(rectype: finder(rech.text)[index])),
                );
              }
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  height: 160,
                  width: 165,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                          width: 50,
                          image: AssetImage(
                              'Icons/khadamat/${servsnums[finder(rech.text)[index]]}.jpg')),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        finder(rech.text)[index],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 0,
        ),
      ),
      drawer: const DrawerContent(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (openned) {
                    openned = false;
                    searchi = const Icon(Icons.search);
                  } else {
                    searchi = const Icon(Icons.cancel);
                    rech.clear();
                    openned = true;
                  }
                });
              },
              icon: searchi)
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
            logo
          ],
        ),
      ),
    );
  }
}
