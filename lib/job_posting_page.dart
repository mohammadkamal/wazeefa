import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wazeefa/job.dart';
import 'package:wazeefa/link_web_view.dart';

class JobPostingPage extends StatefulWidget {
  final Job job;

  const JobPostingPage({Key key, @required this.job}) : super(key: key);

  _JobPostingPageState createState() => _JobPostingPageState();
}

class _JobPostingPageState extends State<JobPostingPage> {
  Widget _titleWidget() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        widget.job.title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        softWrap: true,
      ),
    );
  }

  Widget _typeWidget() {
    return Padding(
        padding: EdgeInsets.only(left: 8),
        child: Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.grey[300]),
          child: Text(widget.job.type),
        ));
  }

  Widget _companyNameTopWidget() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Text(
          widget.job.companyName,
          style: TextStyle(fontSize: 15, color: Colors.blue),
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LinkWebView(
                    link: widget.job.companyURL,
                  ))),
    );
  }

  Widget _locationWidget() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.blue[300]),
          Text(
            widget.job.location,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget _timeWidget() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text('Posted at ' + widget.job.createTime),
    );
  }

  Widget _howToApplyWidget() {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.yellow[300],
          border: Border.all(color: Colors.brown),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'How to apply:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.all(8),
          ),
          Html(data: widget.job.howToApply)
        ],
      ),
    );
  }

  Widget _topInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleWidget(),
        _typeWidget(),
        _companyNameTopWidget(),
        _locationWidget(),
        _timeWidget(),
        _howToApplyWidget()
      ],
    );
  }

  Widget _descriptionCard() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            'Description:',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: Html(
            data: widget.job.description,
          ),
        )
      ],
    ));
  }

  Widget _bottomSheet() {
    return ListView(
      children: [
        ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LinkWebView(link: widget.job.jobURL))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('View Posting at website'), Icon(Icons.web)],
            ))
      ],
      shrinkWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job.title),
      ),
      body: ListView(
        children: [_topInfoCard(), _descriptionCard()],
      ),
      bottomSheet: _bottomSheet(),
    );
  }
}
