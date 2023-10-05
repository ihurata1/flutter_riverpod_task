// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root/components/app_container.dart';
import 'package:root/constants/app.dart';
import 'package:root/helpers/helper.dart';
import 'package:root/screens/home.dart';
import 'package:root/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await AppHelper.initialize();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Application.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isAuthenticated = false;
  @override
  void initState() {
    // TODO: implement initState
    getPrefInstance();
    super.initState();
  }

  Future<void> getPrefInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    if (prefs.getString("token") == null) {
      setState(() {
        isAuthenticated = false;
      });
    } else if (prefs.getString("token") == "") {
      setState(() {
        isAuthenticated = false;
      });
    } else {
      setState(() {
        isAuthenticated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(isAuthenticated);

    return AppContainer(
      child: isAuthenticated ? HomeScreen() : LoginScreen(),
    );
  }
}
