import 'package:flutter/material.dart';
import 'package:wazeefa/job.dart';
import 'package:wazeefa/job_posting_item.dart';

class SearchResults extends StatefulWidget {
  final List<Job> jobs;

  const SearchResults({Key key, this.jobs}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    if (widget.jobs.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text('No search results yet...'),
      );
    } else {
      return SingleChildScrollView(
        padding: EdgeInsets.only(top: 80),
        child: Column(
            children: widget.jobs
                .map((e) => JobPostingItem(
                      job: e,
                    ))
                .toList()),
      );
    }
  }
}
