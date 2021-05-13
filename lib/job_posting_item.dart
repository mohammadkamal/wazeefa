import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wazeefa/job.dart';
import 'package:wazeefa/job_posting_page.dart';

class JobPostingItem extends StatelessWidget {
  final Job job;

  const JobPostingItem({Key key, @required this.job}) : super(key: key);

  Widget _photoWidget() {
    return CachedNetworkImage(
        imageUrl: job.companyLogoURL,
        placeholder: (context, url) => Row(
              children: [CircularProgressIndicator()],
              mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
