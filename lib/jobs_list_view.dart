import 'package:flutter/material.dart';
import 'package:wazeefa/adzuna_job_posting_item.dart';
import 'package:wazeefa/adzuna_jobs/adzuna_job.dart';
import 'package:wazeefa/fetch_rest_api.dart';
import 'package:wazeefa/saved_jobs.dart';
import 'package:wazeefa/search_page.dart';

class JobsPage extends StatefulWidget {
  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wazeefa'),
        actions: [/*
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()))),
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SavedJobs())),
              icon: Icon(Icons.bookmarks))*/
        ],
      ),
      body: FutureBuilder<List<AdzunaJob>>(
        future: fetchAdzunaJobs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(snapshot.error),
                  OutlinedButton(onPressed: fetchJobs, child: Text('Reload'))
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return RefreshIndicator(
                child: ListView(
                    shrinkWrap: true,
                    children: snapshot.data.isNotEmpty
                        ? snapshot.data
                            .map((e) => AdzunaJobPostingItem(
                                  adzunaJob: e,
                                ))
                            .toList()
                        : []),
                onRefresh: fetchJobs);
          }

          return Container(
            child: CircularProgressIndicator(),
            alignment: Alignment.center,
          );
        },
      ),
    );
  }
}
