import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MaterialApp(
    title: 'Tasker',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepOrange,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    supportedLocales: [
      const Locale('en', 'GB'),
    ],
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: MainScreen()),
    );
  }
}
