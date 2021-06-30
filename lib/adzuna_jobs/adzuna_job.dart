import 'package:json_annotation/json_annotation.dart';

import 'adzuna_job_category.dart';
import 'adzuna_job_company.dart';
import 'adzuna_job_location.dart';

@JsonSerializable()
class AdzunaJob {
  AdzunaJob(
      {this.salaryMinimum,
      this.jobTitle,
      this.jobLocation,
      this.redirectURL,
      this.jobCategory,
      this.adRef,
      this.dateOfcreation,
      this.jobCompany,
      this.jobDescription,
      this.jobID,
      this.salaryIsPredicted,
      this.salaryMaximum,
      this.latitude,
      this.longitude});

  dynamic salaryMinimum;
  String jobTitle;
  AdzunaJobLocation jobLocation;
  String redirectURL;
  AdzunaJobCategory jobCategory;
  String adRef;
  String salaryIsPredicted; // as integers 0, 1
  String dateOfcreation;
  String jobDescription;
  dynamic salaryMaximum;
  AdzunaJobCompany jobCompany;
  int jobID;
  dynamic latitude;
  dynamic longitude;

  factory AdzunaJob.fromJson(Map<String, dynamic> json) =>
      _$AdzunaJobFromJson(json);
  Map<String, dynamic> toJson() => _$AdzunaJobToJson(this);
}

AdzunaJob _$AdzunaJobFromJson(Map<String, dynamic> json) => AdzunaJob(
    redirectURL: json['redirect_url'],
    adRef: json['adref'],
    jobTitle: json['title'],
    jobID: int.tryParse(json['id']),
    salaryIsPredicted: json['salary_is_predicted'],
    dateOfcreation: json['created'],
    salaryMaximum: json['salary_max'],
    salaryMinimum: json['salary_min'],
    jobDescription: json['description'],
    longitude: json['longitude'],
    latitude: json['latitude'],
    jobCategory: AdzunaJobCategory.fromJson(json['category']),
    jobCompany: AdzunaJobCompany.fromJson(json['company']),
    jobLocation: AdzunaJobLocation.fromJson(json['location']));

Map<String, dynamic> _$AdzunaJobToJson(AdzunaJob adzunaJob) =>
    <String, dynamic>{
      'redirect_url': adzunaJob.redirectURL,
      'adref': adzunaJob.adRef,
      'title': adzunaJob.jobTitle,
      'id': adzunaJob.jobID,
      'salary_is_predicted': adzunaJob.salaryIsPredicted,
      'created': adzunaJob.dateOfcreation,
      'salary_max': adzunaJob.salaryMaximum,
      'salary_min': adzunaJob.salaryMinimum,
      'description': adzunaJob.jobDescription,
      'latitude': adzunaJob.latitude,
      'longitude': adzunaJob.longitude,
      'category': adzunaJob.jobCategory.toJson(),
      'company': adzunaJob.jobCompany.toJson(),
      'location': adzunaJob.jobLocation.toJson()
    };
