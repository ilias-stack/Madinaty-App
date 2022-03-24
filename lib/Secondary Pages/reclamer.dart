// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:madinaty/usermanager.dart';

// ignore: must_be_immutable
class Reclamer extends StatefulWidget {
  late String rectype;
  Reclamer({Key? key, required this.rectype}) : super(key: key);

  @override
  State<Reclamer> createState() => _ReclamerState();
}

class _ReclamerState extends State<Reclamer> {
  final ImagePicker _picker = ImagePicker();
  Location location = Location();

  // ignore: non_constant_identifier_names
  Future<LocationData?> LocateDevice() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  XFile? photo;
  TextEditingController desc = TextEditingController();
  final storage = firebasestorage.FirebaseStorage.instance;
  final reclams = FirebaseFirestore.instance.collection('reclamations');
  // ignore: non_constant_identifier_names
  bool SendInProgress = false;

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
      body: !SendInProgress
          ? SingleChildScrollView(
              child: Column(
              children: [
                const SizedBox(height: 40),
                const Text('Informations de la réclamation',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 98, 98, 98))),
                const Divider(),
                const SizedBox(height: 20),
                Center(
                    child: Row(children: [
                  const SizedBox(width: 40),
                  const Text('Catégorie :', style: TextStyle(fontSize: 16)),
                  Text(widget.rectype,
                      style: const TextStyle(
                          fontSize: 18, color: Color.fromARGB(253, 0, 63, 16)))
                ])),
                const SizedBox(height: 20),
                photo == null
                    ? GestureDetector(
                        onTap: () async {
                          photo = await _picker.pickImage(
                            source: ImageSource.camera,
                          );
                          setState(() {});
                        },
                        child: Center(
                          child: Container(
                            height: 400,
                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    const Color.fromRGBO(100, 100, 100, 0.2)),
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.camera_enhance,
                                      color: Colors.grey,
                                    ),
                                    Text('Prendre une photo',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey))
                                  ]),
                            ),
                          ),
                        ))
                    : InteractiveViewer(
                        child: GestureDetector(
                          onTap: () async {
                            photo = await _picker.pickImage(
                                source: ImageSource.camera);
                            setState(() {});
                          },
                          child: Center(
                            child: Container(
                              height: 400,
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromRGBO(100, 100, 100, 0.1)),
                              child: Image.file(File(photo!.path)),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                SizedBox(
                  child: TextFormField(
                    controller: desc,
                    maxLines: 3,
                    maxLength: 1000,
                    decoration: const InputDecoration(
                      focusColor: Color.fromRGBO(8, 103, 97, 1),
                      hintText: 'Description',
                      hoverColor: Color.fromRGBO(8, 103, 97, 1),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20))),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width / 1.2,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.7,
                  child: RaisedButton(
                    onPressed: () async {
                      if (photo != null && desc.text != '') {
                        GeoPoint? position;

                        await LocateDevice().then((value) {
                          position = GeoPoint(
                              value!.latitude ?? 0, value.longitude ?? 0);
                          setState(() {
                            SendInProgress = true;
                          });
                        });

                        if (position != null) {
                          storage
                              .ref('Reclamations/${photo!.name}')
                              .putFile(File(photo!.path))
                              .then((p0) async {
                            var url = await p0.ref.getDownloadURL();
                            reclams.add({
                              'localisation': [
                                position!.latitude,
                                position!.longitude
                              ],
                              'photo': url,
                              'description': desc.text,
                              'categorie': widget.rectype,
                              'etat': 'En cours de traitement',
                              'date': DateTime(DateTime.now().year,
                                      DateTime.now().month, DateTime.now().day)
                                  .toString()
                                  .split(" ")[0],
                              'owner': !MyUsers.isanonyme()
                                  ? MyUsers.infos()['email']
                                  : 'anonyme'
                            }).then((value) {
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                  msg: "Envoyé",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          }).onError((error, stackTrace) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Veuillez réessayer"),
                              duration: Duration(milliseconds: 500),
                            ));
                          });
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Données insuffisants"),
                          duration: Duration(milliseconds: 500),
                        ));
                      }
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: const Text(
                      "Envoyer",
                      style: TextStyle(
                          color: Color.fromRGBO(70, 160, 150, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 40)
              ],
            ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                          color: Color.fromRGBO(70, 160, 150, 1))),
                ),
                SizedBox(height: 20),
                Text(
                  'Envoi en cours...',
                  style: TextStyle(color: Colors.black38),
                )
              ],
            ),
    );
  }
}
