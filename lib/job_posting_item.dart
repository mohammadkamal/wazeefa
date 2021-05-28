import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wazeefa/job.dart';
import 'package:wazeefa/job_posting_page.dart';
import 'package:wazeefa/jobs_database.dart';
import 'package:wazeefa/link_web_view.dart';

class JobPostingItem extends StatelessWidget {
  final Job job;

  const JobPostingItem({Key key, @required this.job}) : super(key: key);

  Widget _photoWidget() {
    return CachedNetworkImage(
        imageUrl: job.companyLogoURL,
        placeholder: (context, url) => Container(
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            ),
        errorWidget: (context, url, error) => Container(
              child: Icon(Icons.broken_image),
              alignment: Alignment.center,
            ),
        height: 100,
        width: 100);
  }

  Widget _titleWidget() {
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 3),
      width: 200,
      child: Text(
        job.title,
        style: TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _companyNameWidget() {
    return Container(
        padding: EdgeInsets.only(top: 3, bottom: 3),
        width: 200,
        child: Text(
          'at ' + job.companyName,
          softWrap: true,
          style: TextStyle(color: Colors.grey),
        ));
  }

  Widget _jobTypeWidget() {
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 3),
      child: Text(
        job.type,
        softWrap: true,
      ),
    );
  }

  Widget _locationWidget() {
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 3),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Colors.blue[300],
          ),
          Container(
              width: 150,
              child: Text(
                job.location,
                overflow: TextOverflow.ellipsis,
              ))
        ],
      ),
    );
  }

  Widget _infoWidget() {
    return Container(
        padding: EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleWidget(),
            _companyNameWidget(),
            _jobTypeWidget(),
            _locationWidget()
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5))]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_photoWidget(), _infoWidget()],
        ),
      ),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => JobPostingPage(job: job))),
      onLongPress: () => showDialog(
          context: context,
          builder: (context) => OnLongPressDialog(
                job: job,
              )),
    );
  }
}

class OnLongPressDialog extends StatefulWidget {
  final Job job;

  const OnLongPressDialog({Key key, this.job}) : super(key: key);
  @override
  _OnLongPressDialogState createState() => _OnLongPressDialogState();
}

class _OnLongPressDialogState extends State<OnLongPressDialog> {
  bool _isSaved = false;

  Future<void> _checkIfSaved() async {
    var _result = await JobsDatabase.instance.findJob(widget.job.jobID);
    if (_result != _isSaved) {
      setState(() {
        _isSaved = _result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  void _onSaveTap() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Actions on job'),
      content: Text('Choose what to do with this posting'),
      actions: [
        TextButton(
            onPressed: _onSaveTap,
            child: _isSaved ? Text('Unsave') : Text('Save')),
        TextButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LinkWebView(link: widget.job.jobURL))),
          child: Text('View online'),
        ),
      ],
    );
  }
}
