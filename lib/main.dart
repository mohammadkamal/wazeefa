import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wazeefa/job.dart';
import 'package:http/http.dart' as http;
import 'package:wazeefa/job_posting_item.dart';

Future<List<Job>> fetchJobs() async {
  final respone = await http
      .get(Uri.parse('https://jobs.github.com/positions.json?description='));
  final parsed = jsonDecode(respone.body).cast<Map<String, dynamic>>();
  return parsed.map<Job>((json) => Job.fromJson(json)).toList();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wazeefa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JobsPage(title: 'Wazeefa'),
    );
  }
}

class JobsPage extends StatefulWidget {
  JobsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Job>>(
        future: fetchJobs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Row(
              children: [
                OutlinedButton(onPressed: fetchJobs, child: Text('Reload'))
              ],
            );
          } else if (snapshot.hasData) {
            return RefreshIndicator(
                child: ListView(
                    shrinkWrap: true,
                    children: snapshot.data.isNotEmpty
                        ? snapshot.data
                            .map((e) => JobPostingItem(
                                  job: e,
                                ))
                            .toList()
                        : []),
                onRefresh: fetchJobs);
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
