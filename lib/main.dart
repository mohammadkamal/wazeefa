import 'package:flutter/material.dart';
import 'package:wazeefa/jobs_database.dart';
import 'package:wazeefa/jobs_list_view.dart';

void main() {
  runApp(Wazeefa());
}

class Wazeefa extends StatefulWidget {
  @override
  _WazeefaState createState() => _WazeefaState();
}

class _WazeefaState extends State<Wazeefa> {
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    JobsDatabase.instance.onDatabaseIntialize();
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
        elevation: 0,
        backwardsCompatibility: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black));
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red[400])));
  }

  ThemeData _defaultThemeData() {
    return ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: _appBarTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wazeefa',
      theme: _defaultThemeData(),
      home: JobsPage(),
    );
  }
}
