class Job {
  final String jobID;
  final String type;
  final String jobURL;
  final String createTime;
  final String companyName;
  final String companyURL;
  final String location;
  final String title;
  final String description;
  final String companyLogoURL;
  final String howToApply;

  Job(
      {this.jobID,
      this.type,
      this.jobURL,
      this.createTime,
      this.companyName,
      this.companyURL,
      this.location,
      this.title,
      this.description,
      this.companyLogoURL,
      this.howToApply});

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  //For sqlite
  Map<String, dynamic> toDatabaseMap() => _$JobToDatabaseMap(this);
}

Job _$JobFromJson(Map<String, dynamic> json) {
  return Job(
      jobID: json['id'],
      type: json['type'],
      jobURL: json['url'],
      createTime: json['created_at'],
      companyName: json['company'],
      companyURL: json['company_url'],
      location: json['location'],
      title: json['title'],
      description: json['description'],
      companyLogoURL: json['company_logo'],
      howToApply: json['how_to_apply']);
}

Map<String, dynamic> _$JobToDatabaseMap(Job job) => <String, dynamic>{
      'jobID': job.jobID,
      'type': job.type,
      'jobURL': job.jobURL,
      'createTime': job.createTime,
      'companyName': job.companyName,
      'companyURL': job.companyURL,
      'location': job.location,
      'title': job.title,
      'description': job.description,
      'companyLogoURL': job.companyLogoURL,
      'howToApply': job.howToApply
    };
