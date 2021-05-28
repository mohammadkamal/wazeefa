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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wazeefa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JobsPage(),
    );
  }
}

