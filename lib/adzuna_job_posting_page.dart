import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wazeefa/adzuna_jobs/adzuna_job.dart';
import 'package:wazeefa/link_web_view.dart';

class AdzunaJobPostingPage extends StatefulWidget {
  final AdzunaJob job;

  const AdzunaJobPostingPage({Key key, @required this.job}) : super(key: key);

  _AdzunaJobPostingPageState createState() => _AdzunaJobPostingPageState();
}

class _AdzunaJobPostingPageState extends State<AdzunaJobPostingPage> {
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1.5)
        ]);
  }

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Text(
        widget.job.jobTitle,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        softWrap: true,
      ),
    );
  }

  Widget _companyNameTopWidget() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        widget.job.jobCompany.companyDisplayName,
        style: TextStyle(fontSize: 15, color: Colors.blue),
      ),
    );
  }

  Widget _locationWidget() {
    return Container(
        padding: EdgeInsets.all(8),
        child: Text(
          widget.job.jobLocation.displayName,
          style: TextStyle(color: Colors.grey),
        ));
  }

  Widget _timeWidget() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text('Posted at ' + widget.job.dateOfcreation),
    );
  }

  Widget _typeLocationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _locationWidget(),
      ],
    );
  }

  Widget _topInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleWidget(),
        _typeLocationWidget(),
        _companyNameTopWidget(),
        _timeWidget(),
      ],
    );
  }

  Widget _descriptionCard() {
    return Container(
        decoration: _boxDecoration(),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                'Description',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[300]),
              ),
            ),
            Container(
              child: Html(
                data: widget.job.jobDescription,
              ),
            )
          ],
        ));
  }

  Widget _bottomLink() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LinkWebView(link: widget.job.redirectURL))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('View Posting at website'),
              Icon(CupertinoIcons.globe)
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Job details'),
        ),
        body: Container(
            color: Colors.grey[100],
            child: Stack(
              children: [
                SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        _topInfoCard(),
                        _descriptionCard(),
                      ],
                    )),
                _bottomLink()
              ],
            )));
  }
}
