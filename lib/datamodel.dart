// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:madinaty/usermanager.dart';

class DataModel extends StatelessWidget {
  late QueryDocumentSnapshot<Object?> doc;
  DataModel({
    required this.doc,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (bld) {
                return AlertDialog(
                  content: InfoPage(
                    doc: doc,
                  ),
                );
              });
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          height: 420,
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    1.0,
                    1.0,
                  ),
                )
              ],
              color: doc['etat'] == "En cours de traitement"
                  ? Colors.white
                  : doc['etat'] == "Approuvé"
                      ? const Color.fromARGB(255, 253, 249, 242)
                      : const Color.fromARGB(255, 213, 247, 198),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyUsers.islogged()
                  ? MyUsers.infos()['email'] == doc['owner']
                      ? Stack(
                          children: [
                            GestureDetector(
                              child: const Icon(Icons.cancel_sharp,
                                  size: 30,
                                  color: Color.fromARGB(255, 173, 74, 66)),
                              onTap: () {
                                showDialog(
                                    builder: (ctx) {
                                      return AlertDialog(
                                        content: const Text(
                                            "Vous voulez vraiment supprimer cette réclamations ?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                doc.reference.delete();
                                              },
                                              child: const Text('Oui')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Non'))
                                        ],
                                      );
                                    },
                                    context: context);
                              },
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.all(15),
                                child: Text(
                                  DateTime.parse(doc['date'])
                                              .difference(DateTime.now())
                                              .inDays ==
                                          0
                                      ? '''Aujourd'hui'''
                                      : '''${(-DateTime.parse(doc['date']).difference(DateTime.now()).inDays).toString()} jours''',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            child: Text(
                              DateTime.parse(doc['date'])
                                          .difference(DateTime.now())
                                          .inDays ==
                                      0
                                  ? '''Aujourd'hui'''
                                  : '''${(-DateTime.parse(doc['date']).difference(DateTime.now()).inDays).toString()} jours''',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                  : Center(
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          DateTime.parse(doc['date'])
                                      .difference(DateTime.now())
                                      .inDays ==
                                  0
                              ? '''Aujourd'hui'''
                              : '''${(-DateTime.parse(doc['date']).difference(DateTime.now()).inDays).toString()} jours''',
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
              const Divider(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: InteractiveViewer(
                          child: Image.network(
                            doc['photo'],
                            errorBuilder: (ctx, obj, err) {
                              return const Center(
                                child: Image(
                                    image: AssetImage('Icons/noconn.png')),
                              );
                            },
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Center(
                  child: Container(
                    height: 330,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(100, 100, 100, 0.1)),
                    child: Image.network(
                      doc['photo'],
                      errorBuilder: (ctx, obj, err) {
                        return const Center(
                          child: Image(
                              height: 90,
                              image: AssetImage('Icons/noconn.png')),
                        );
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  late QueryDocumentSnapshot<Object?> doc;

  InfoPage({required this.doc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Container(
              color: const Color.fromARGB(51, 148, 148, 148),
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                const Text('Publié le :  ',
                    style: TextStyle(color: Colors.grey, fontSize: 20)),
                Text(doc['date'],
                    style: const TextStyle(
                        color: Color.fromARGB(255, 110, 110, 110),
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ])),
          const SizedBox(
            height: 20,
          ),
          Container(
              color: const Color.fromARGB(51, 148, 148, 148),
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                const Text('Catégorie :  ',
                    style: TextStyle(color: Colors.grey, fontSize: 20)),
                Text(doc['categorie'],
                    style: const TextStyle(
                        color: Color.fromARGB(255, 110, 110, 110),
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ])),
          const SizedBox(
            height: 20,
          ),
          Container(
              color: const Color.fromARGB(51, 148, 148, 148),
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Localisation :',
                        style: TextStyle(color: Colors.grey, fontSize: 20)),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Mapi(
                            lat: doc['localisation'][0],
                            long: doc['localisation'][1]),
                        height: 200),
                  ])),
          const SizedBox(
            height: 20,
          ),
          Container(
              color: const Color.fromARGB(51, 148, 148, 148),
              padding: const EdgeInsets.all(20),
              width: double.maxFinite,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Description :',
                        style: TextStyle(color: Colors.grey, fontSize: 20)),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(doc['description'],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ])),
          const SizedBox(
            height: 20,
          ),
          Container(
              color: const Color.fromARGB(51, 148, 148, 148),
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              child: Row(children: [
                const Text('État : ',
                    style: TextStyle(color: Colors.grey, fontSize: 20)),
                Text(doc['etat'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: doc['etat'] == 'En cours de traitement'
                            ? const Color.fromARGB(178, 175, 114, 23)
                            : doc['etat'] == 'Approuvé'
                                ? const Color.fromARGB(255, 128, 199, 36)
                                : Colors.green))
              ]))
        ]),
      ),
    );
  }
}

class Mapi extends StatelessWidget {
  late double lat, long;
  Mapi({required this.lat, required this.long, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options:
          MapOptions(center: LatLng(lat, long), minZoom: 13.5, maxZoom: 18),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(markers: [
          Marker(
              point: LatLng(lat, long),
              width: 30,
              height: 30,
              builder: (context) => GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: "($lat,$long)"))
                          .then((value) {
                        Fluttertoast.showToast(
                            msg: "Cordonnées copiés",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    },
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 30,
                    ),
                  ))
        ])
      ],
    );
  }
}
