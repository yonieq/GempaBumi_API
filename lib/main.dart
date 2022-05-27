import 'package:bmkg_rest/controllerLogin.dart';
import 'package:bmkg_rest/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Gempa Bumi';
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ControllerLogin())
      ],
      child: MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(
        ),
      ),
    );
  }
}
