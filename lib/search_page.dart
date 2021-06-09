import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wazeefa/fetch_rest_api.dart';
import 'package:wazeefa/job.dart';
import 'package:wazeefa/search_results.dart';

enum FullTimeSearch { yes, no }

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _textController = TextEditingController();
  List<Job> _jobs = [];

  @override
  void dispose() {
    _textController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  InputBorder _textFieldBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(width: 1));
  }

  Widget _clearTextFieldButton(TextEditingController controller) {
    return IconButton(
      iconSize: 15,
      onPressed: () => controller.clear(),
      icon: Icon(Icons.clear),
      color: Colors.black,
    );
  }

  Widget _searchTextField() {
    return Container(
        padding: EdgeInsets.all(5),
        child: TextField(
          textInputAction: TextInputAction.search,
          onSubmitted: (value) async {
            _jobs = await searchJobs(value, '', false);
            if (_jobs.isNotEmpty) {
              setState(() {});
            }
          },
          controller: _textController,
          decoration: InputDecoration(
              hintText: 'Search for your job title...',
              suffixIcon: _clearTextFieldButton(_textController),
              border: _textFieldBorder()),
        ));
  }

  Widget _customizeButton() {
    return ElevatedButton(
        onPressed: () {
          _createBottomSheet();
        },
        child: Icon(Icons.bar_chart));
  }

  Widget _searchCard() {
    return Container(
      constraints: BoxConstraints(maxHeight: 69),
      color: Colors.white,
      child: Column(
        children: [
          Row(children: [
            Flexible(
              child: _searchTextField(),
            ),
            _customizeButton()
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldStateKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Advanced Search'),
        ),
        body: Stack(
          children: [
            SearchResults(jobs: _jobs),
            _searchCard(),
          ],
        ));
  }

  /////////////////////// Bottom Sheet ///////////////////////////////////////////////

  PersistentBottomSheetController _sheetController;
  final _locationController = TextEditingController();
  FullTimeSearch _fullTimeSearch = FullTimeSearch.yes;

  Widget _searchLocationField() {
    return Container(
        padding: EdgeInsets.all(5),
        child: TextField(
            controller: _locationController,
            decoration: InputDecoration(
              hintText: 'Enter your location...',
              suffixIcon: _clearTextFieldButton(_locationController),
              border: _textFieldBorder(),
            )));
  }

  Widget _fullTimeRadio() {
    return Column(children: [
      Text('Full time'),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio<FullTimeSearch>(
              value: FullTimeSearch.yes,
              groupValue: _fullTimeSearch,
              onChanged: (value) {
                _sheetController.setState(() {
                  _fullTimeSearch = value;
                });
              }),
          Text('Yes'),
          Radio<FullTimeSearch>(
              value: FullTimeSearch.no,
              groupValue: _fullTimeSearch,
              onChanged: (value) {
                _sheetController.setState(() {
                  _fullTimeSearch = value;
                });
              }),
          Text('No')
        ],
      )
    ]);
  }

  bool _fullTimeConverter() {
    if (_fullTimeSearch == FullTimeSearch.no) {
      return false;
    } else {
      return true;
    }
  }

  Widget _searchButton() {
    return Container(
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)))),
            onPressed: () async {
              _jobs = await searchJobs(_textController.text,
                  _locationController.text, _fullTimeConverter());
              if (_jobs.isNotEmpty) {
                setState(() {});
              }
            },
            child: Text('Show results')));
  }

  Widget _showAdvancedBottomSheet() {
    return SingleChildScrollView(
        child: Column(
      children: [_fullTimeRadio(), _searchLocationField(), _searchButton()],
    ));
  }

  void _createBottomSheet() {
    _sheetController = scaffoldStateKey.currentState
        .showBottomSheet((context) => _showAdvancedBottomSheet());
  }
}
