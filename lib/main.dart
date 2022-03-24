import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:madinaty/Main%20Pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const WaitPage(),
    title: 'Madinaty-App',
    theme: ThemeData(
        fontFamily: 'Raleway',
        canvasColor: Colors.white,
        primaryColor: Colors.grey,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.grey),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color.fromRGBO(5, 111, 109, 1))),
  ));
}

class WaitPage extends StatefulWidget {
  const WaitPage({Key? key}) : super(key: key);

  @override
  State<WaitPage> createState() => _WaitPageState();
}

class _WaitPageState extends State<WaitPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), route);
  }

  route() async {
    final conState = await hasNetwork();
    if (conState) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Aucune connection internet'),
                content: IconButton(
                    onPressed: () async {
                      var connected = await hasNetwork();
                      if (connected) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Color.fromRGBO(133, 195, 84, 0.98),
                    )));
          });
    }
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        const Center(
          child: Image(
            image: AssetImage('assets/Logo.jpg'),
            height: 250,
            width: 250,
          ),
        ),
      ],
    );
  }
}
