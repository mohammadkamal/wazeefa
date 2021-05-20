import 'dart:convert';

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
