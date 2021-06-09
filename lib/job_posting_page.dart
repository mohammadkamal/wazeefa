import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wazeefa/job.dart';
import 'package:wazeefa/jobs_database.dart';
import 'package:wazeefa/link_web_view.dart';

class JobPostingPage extends StatefulWidget {
  final Job job;

  const JobPostingPage({Key key, @required this.job}) : super(key: key);

  _JobPostingPageState createState() => _JobPostingPageState();
}

class _JobPostingPageState extends State<JobPostingPage> {
  bool _isSaved = false;

  Future<void> _checkIfSaved() async {
    var _result = await JobsDatabase.instance.findJob(widget.job.jobID);
    if (_result != _isSaved) {
      setState(() {
        _isSaved = _result;
      });
    }
  }

  void initState() {
    super.initState();
    _checkIfSaved();
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1.5)
        ]);
  }

  Widget _companyLogoWidget() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        width: 150,
        height: 150,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2)
        ]),
        child: FittedBox(
            fit: BoxFit.fill,
            child: CachedNetworkImage(
              imageUrl: widget.job.companyLogoURL,
              placeholder: (context, url) => Container(
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              ),
              errorWidget: (context, url, error) => Container(
                child: Icon(Icons.broken_image),
                alignment: Alignment.center,
              ),
              alignment: Alignment.center,
            )));
  }

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Text(
        widget.job.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        softWrap: true,
      ),
    );
  }

  Widget _typeWidget() {
    return Container(
      margin: EdgeInsets.only(left: 8),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: Text(widget.job.type),
    );
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
        child: Text(
          widget.job.location,
          style: TextStyle(color: Colors.grey),
        ));
  }

  Widget _timeWidget() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text('Posted at ' + widget.job.createTime),
    );
  }

  Widget _howToApplyWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(8),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'How to apply',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.blue[300]),
            ),
            padding: EdgeInsets.all(8),
          ),
          Html(data: widget.job.howToApply)
        ],
      ),
    );
  }

  Widget _typeLocationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _typeWidget(),
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
                data: widget.job.description,
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
                  builder: (context) => LinkWebView(link: widget.job.jobURL))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('View Posting at website'),
              Icon(CupertinoIcons.globe)
            ],
          )),
    );
  }

  Widget _bookmarkButton() {
    return IconButton(
      icon: _isSaved
          ? Icon(Icons.bookmark_remove)
          : Icon(
              Icons.bookmark_add_outlined,
            ),
      onPressed: () async {
        if (!_isSaved) {
          await JobsDatabase.instance
              .addJob(widget.job)
              .whenComplete(() => setState(() {
                    _isSaved = !_isSaved;
                  }));
        } else {
          await JobsDatabase.instance
              .deleteJob(widget.job.jobID)
              .whenComplete(() => setState(() {
                    _isSaved = !_isSaved;
                  }));
        }
      },
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
          actions: [_bookmarkButton()],
        ),
        body: Container(
            color: Colors.grey[100],
            child: Stack(
              children: [
                SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        _companyLogoWidget(),
                        _topInfoCard(),
                        _descriptionCard(),
                        _howToApplyWidget()
                      ],
                    )),
                _bottomLink()
              ],
            )));
  }
}
