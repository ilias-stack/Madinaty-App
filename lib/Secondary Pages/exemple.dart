// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../datamodel.dart';

class ExemplePage extends StatelessWidget {
  const ExemplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.white,
        title: Container(
          padding: const EdgeInsets.only(right: 45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                  image: AssetImage('assets/Logo-modified.png'),
                  width: 40,
                  height: 40),
              Text(
                '  Categories',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      body: ExempleTypes(),
    );
  }
}

class ExempleTypes extends StatelessWidget {
  ExempleTypes({Key? key}) : super(key: key);
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: servs.length,
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              ListTile(
                leading: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image(
                        image: AssetImage(
                            'Icons/khadamat/${servsnums[servs[index]]}.jpg'))),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_sharp,
                  size: 40,
                ),
                title: Text(
                  servs[index],
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 47, 83, 49)),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => ExempleContent(
                            categ: servs[index],
                          )));
                },
              ),
              const Divider()
            ],
          );
        });
  }
}

class ExempleContent extends StatefulWidget {
  late String categ;
  ExempleContent({required this.categ, Key? key}) : super(key: key);

  @override
  State<ExempleContent> createState() => _ExempleContentState();
}

class _ExempleContentState extends State<ExempleContent> {
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.white,
        title: const Image(
            image: AssetImage('assets/Logo-modified.png'),
            width: 40,
            height: 40),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('reclamations')
              .where('categorie', isEqualTo: widget.categ)
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
                              height: 120,
                              image: AssetImage('Icons/empty.png')),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              'Cette categorie est vide',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 22),
                            ),
                          )
                        ]
                      : a);
            }
          })),
    );
  }
}
