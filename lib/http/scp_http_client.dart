import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:scp/src/common/url.dart';

class ScpHttpClient {
  static const String _baseUrl = '192.168.0.2';

  static Future<String?> post(String detailUrl) async {
    var url = Uri.http(
      _baseUrl,
      Comm_Params.URL_HOME.replaceAll(Comm_Params.USER_ID, '1'),
    );

    var response = await http.post(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> get(String detailUrl) async {
    var url = Uri.http(
      _baseUrl,
      Comm_Params.URL_HOME.replaceAll(Comm_Params.USER_ID, '1'),
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
  //   GET /homeview/{userId}
  //   json
  //   [
  //   {
  //     "projectName": "String",
  //     "tasklist":[
  //       {
  //         "taskId": 4,
  //         "projectinuserId": 5,
  //         "taskContent": "String",
  //         "taskOwner": "String",
  //         "taskRequester": "string",
  //         "taskComplete": INTEGER,
  //         "taskAccept": INTEGER,
  //         "taskRequesttime": "datetime",
  //         "taskDeadline": "datetime",
  //         "taskCreatetime": "datetime"
  //       }
  //     ],
  //     "userCode": "p_member",
  //     "projectId": 1
  //   },
  //   {
  //   "projectName": "테스트003",
  //   "tasklist": null,
  //   "userCode": "p_leader",
  //   "projectId": 3
  //   }
  //   ]
  // }
}
