import 'package:flutter/material.dart';
import 'package:wazeefa/job.dart';
import 'package:wazeefa/job_posting_item.dart';
import 'package:wazeefa/jobs_database.dart';

class SavedJobs extends StatefulWidget {
  @override
  _SavedJobsState createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  List<Job> _savedJobs;
  @override
  void initState() {
    super.initState();
    getJobs();
  }

  void getJobs() async {
    _savedJobs = await JobsDatabase.instance
        .savedJobs()
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved jobs'),
      ),
      body: ListView(
        children: _savedJobs.isNotEmpty || _savedJobs != null
            ? _savedJobs
                .map((e) => JobPostingItem(
                      job: e,
                    ))
                .toList()
            : [],
      ),
    );
  }
}
