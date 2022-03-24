import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyUsers {
  String? etat;

  static Map infos() {
    var c = FirebaseAuth.instance.currentUser;
    return {'uid': c!.uid, 'email': c.email};
  }

  static bool islogged() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  static bool isanonyme() {
    return FirebaseAuth.instance.currentUser!.isAnonymous;
  }

  static Map? fullInfos() {
    Map<String, String>? informs;
    try {
      FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: infos()['email'])
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          informs = {
            'nom': value.docs[0].data()['nom'],
            'email': value.docs[0].data()['email'],
            'tele': value.docs[0].data()['telephone'],
            'password': value.docs[0].data()['password']
          };
        }
      });
    }
    // ignore: empty_catches
    catch (err) {}
    return informs;
  }
}
