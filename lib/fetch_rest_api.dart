import 'dart:convert';

import 'package:wazeefa/adzuna_jobs/adzuna_job.dart';
import 'package:wazeefa/job.dart';
import 'package:http/http.dart' as http;

Future<List<Job>> fetchJobs() async {
  final respone = await http
      .get(Uri.parse('https://jobs.github.com/positions.json?description='));
  final parsed = jsonDecode(respone.body).cast<Map<String, dynamic>>();
  return parsed.map<Job>((json) => Job.fromJson(json)).toList();
}

Future<List<Job>> searchJobs(
    String description, String location, bool fullTime) async {
  String descriptionVariable =
      description.isNotEmpty ? 'description=' + description : 'description=';
  String locationVariable =
      location.isNotEmpty ? '&location=' + location : '&location=';
  String fullTimeVariable = fullTime ? '&full_time=true' : '';

  final response = await http.get(Uri.parse(
      'https://jobs.github.com/positions.json?' +
          descriptionVariable +
          fullTimeVariable +
          locationVariable));
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<Job>((json) => Job.fromJson(json)).toList();
}

Future<List<AdzunaJob>> fetchAdzunaJobs() async {
  final response = await http.get(
    Uri.parse(
        'https://api.adzuna.com/v1/api/jobs/gb/search/1?app_id=f757421c&app_key=567f50d9d4c8c44895d9160ca1916dc9'),
  );
  var parsed = jsonDecode(response.body);
  var temp = parsed['results'];
  print(temp);
  return parsed['results']
      .map<AdzunaJob>((json) => AdzunaJob.fromJson(json))
      .toList();
}
