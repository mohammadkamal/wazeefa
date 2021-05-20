import 'package:flutter/material.dart';
import 'package:wazeefa/fetch_rest_api.dart';
import 'package:wazeefa/job.dart';
import 'package:wazeefa/job_posting_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  final _locationController = TextEditingController();
  List<Job> _jobs = [];
  bool _dropDownValue = false;
  List<bool> _fullTime = [true, false];

  @override
  void dispose() {
    _textController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Widget _searchTextField() {
    return Container(
        padding: EdgeInsets.all(5),
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
              hintText: 'Search for your job title...',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
              )),
        ));
  }

  Widget _searchFullTime() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Full time?'),
        DropdownButton<bool>(
            hint: Text('Full Time?'),
            value: _dropDownValue,
            onChanged: (newValue) {
              setState(() {
                _dropDownValue = newValue;
              });
            },
            items: _fullTime
                .map((e) =>
                    DropdownMenuItem<bool>(value: e, child: Text(e.toString())))
                .toList()),
      ],
    ));
  }

  Widget _searchLocationField() {
    return Container(
        padding: EdgeInsets.all(5),
        child: TextField(
            controller: _locationController,
            decoration: InputDecoration(
              hintText: 'Enter your location...',
              border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
            )));
  }

  Widget _searchButton() {
    return Container(
        child: ElevatedButton(
            onPressed: () async {
              _jobs = await searchJobs(_textController.text,
                  _locationController.text, _dropDownValue);
              if (_jobs.isNotEmpty) {
                setState(() {});
              }
            },
            child: Text('Search')));
  }

  Widget _searchCard() {
    return Container(
      child: Column(
        children: [
          Row(children: [
            Flexible(
              child: _searchTextField(),
            ),
            _searchFullTime(),
          ]),
          Row(
            children: [
              Flexible(child: _searchLocationField()),
              _searchButton()
            ],
          ),
        ],
      ),
    );
  }

  Widget _searchResults() {
    if (_jobs.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text('No search results yet...'),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
            children: _jobs
                .map((e) => JobPostingItem(
                      job: e,
                    ))
                .toList()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Advanced Search'),
        ),
        body: ListView(children: [_searchCard(), _searchResults()]));
  }
}
