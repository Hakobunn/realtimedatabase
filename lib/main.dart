//Nur Amanina 2011402
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'userdetail.dart';
import 'databaseView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'User Details',
      title: 'Welcome',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createCustomColor(0xFF000080),
        // primarySwatch:Color(0xFF000080),
      ),
      // home: const UserDetailsForm(),
      home: HomePage(),
    );
  }
}

MaterialColor createCustomColor(int colorValue) {
  Map<int, Color> colorMap = {
    50: Color(colorValue),
    100: Color(colorValue),
    200: Color(colorValue),
    300: Color(colorValue),
    400: Color(colorValue),
    500: Color(colorValue),
    600: Color(colorValue),
    700: Color(colorValue),
    800: Color(colorValue),
    900: Color(colorValue),
  };
  return MaterialColor(colorValue, colorMap);
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final Color tdGrey = Colors.grey;
  final Color tdNavyBlue = Color(0xFF000080);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Let's help you manage user details.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/exam.jpg',
                width: 250,
                height: 250,
              ),
              Column(
                children: <Widget>[
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DatabaseViewPage()),
                      );
                    },
                    color: Colors.white60,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: tdGrey.withOpacity(0.8)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "View Users",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserDetailsForm()),
                      );
                    },
                    color: tdNavyBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "User Details Form",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
