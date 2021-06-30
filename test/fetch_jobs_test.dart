import 'package:flutter_test/flutter_test.dart';
import 'package:wazeefa/fetch_rest_api.dart';

void main()
{
  test('Get jobs json', () async{
    print(await fetchAdzunaJobs());
  });
}