import 'package:flutter/material.dart';
import 'package:wazeefa/fetch_rest_api.dart';
import 'package:wazeefa/job.dart';
import 'package:wazeefa/job_posting_item.dart';
import 'package:wazeefa/search_page.dart';

void main() {
  runApp(Wazeefa());
}

class Wazeefa extends StatefulWidget {
  @override
  _WazeefaState createState() => _WazeefaState();
}

class _WazeefaState extends State<Wazeefa> {
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
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage())))
        ],
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
