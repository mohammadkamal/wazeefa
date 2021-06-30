import 'package:flutter/material.dart';
import 'package:wazeefa/adzuna_job_posting_page.dart';
import 'package:wazeefa/adzuna_jobs/adzuna_job.dart';

class AdzunaJobPostingItem extends StatelessWidget {
  final AdzunaJob adzunaJob;

  const AdzunaJobPostingItem({Key key, this.adzunaJob}) : super(key: key);

  Widget _titleWidget() {
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 3),
      width: 200,
      child: Text(
        adzunaJob.jobTitle,
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
          'at ' + adzunaJob.jobCompany.companyDisplayName,
          softWrap: true,
          style: TextStyle(color: Colors.grey),
        ));
  }

  Widget _locationWidget() {
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 3),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Colors.red[400],
          ),
          Container(
              width: 150,
              child: Text(
                adzunaJob.jobLocation.displayName,
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
          children: [_titleWidget(), _companyNameWidget(), _locationWidget()],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1.5)
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_infoWidget()],
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdzunaJobPostingPage(job: adzunaJob))),
    );
  }
}
