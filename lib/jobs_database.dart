import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wazeefa/job.dart';

class JobsDatabase {
  static JobsDatabase get instance => JobsDatabase();

  static Future<Database> futureDatabase;
  static Database database;

  void onDatabaseIntialize() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'saved_jobs_database.db');

    futureDatabase = openDatabase(path, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE savedJobs(jobID TEXT PRIMARY KEY, type TEXT, jobURL TEXT, createTime TEXT, companyName TEXT, companyURL TEXT, location TEXT, title TEXT, description TEXT, companyLogoURL TEXT, howToApply TEXT)');
    }, version: 1);

    database = await futureDatabase;
  }

  Future<void> addJob(Job job) async {
    await database.insert('savedJobs', job.toDatabaseMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteJob(String id) async {
    await database.delete('savedJobs', where: 'jobID = ?', whereArgs: [id]);
  }

  Future<bool> findJob(String id) async {
    final result =
        await database.query('savedJobs', where: 'jobID = ?', whereArgs: [id]);
    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<Job>> savedJobs() async {
    final List<Map<String, dynamic>> jobs = await database.query('savedJobs');

    return List.generate(
        jobs.length,
        (index) => Job(
              jobID: jobs[index]['jobID'],
              jobURL: jobs[index]['jobURL'],
              title: jobs[index]['title'],
              type: jobs[index]['type'],
              howToApply: jobs[index]['howToApply'],
              createTime: jobs[index]['createTime'],
              companyURL: jobs[index]['companyURL'],
              companyLogoURL: jobs[index]['companyLogoURL'],
              description: jobs[index]['description'],
              location: jobs[index]['location'],
              companyName: jobs[index]['companyName'],
            ));
  }
}
