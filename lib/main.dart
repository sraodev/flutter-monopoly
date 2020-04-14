import 'package:flutter/material.dart';
import 'package:monopoly/src/utils/constants.dart';
import 'package:monopoly/src/pages/home_page.dart';

void main() => runApp(MonopolyApp());


class MonopolyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.APP_NAME,
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1C306D),
        accentColor: const Color(0xFFFFAD32),
        fontFamily: 'OpenSans',
        //scaffoldBackgroundColor: Colors.transparent,
      ),
      home: HomePage(),
    );
  }
}
