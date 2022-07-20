import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_parser/http_parser.dart';
import 'package:my_dog_app/services/interceptor_service.dart';

class NetworkService {
  // baseUrl
  static const isTester = true;

  static const DEVELOPMENT_SERVER = "api.thedogapi.com";
  static const DEPLOYMENT_SERVER = "api.thedogapi.com";

  static String get BASEURL {
    if(isTester) {
      return DEVELOPMENT_SERVER;
    } else {
      return DEPLOYMENT_SERVER;
    }
  }

  // apis
  static const API_LIST_BREADS = "/v1/breeds";
  static const API_BREADS_SEARCH = "/v1/breeds/search";
  static const API_LIST_VOTES = "v1/votes";
  static const API_ONE_VOTE = "v1/votes/"; // {ID}

  // headers
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'x-api-key': '19abbefc-b253-4f39-a7ee-769267b6cd56d',
  };

  static Map<String, String> headersForUpload = {
    'Content-Type': 'multipart/form-data',
    'x-api-key': '19abbefc-b253-4f39-a7ee-769267b6cd56d',
  };

  // interceptor
  static final http = InterceptedHttp.build(interceptors: [
    InterceptorService(),
  ]);

  // methods
  static Future<String?> GET(String api, Map<String, String> params) async{
    Uri url = Uri.https(BASEURL, api, params);
    final response = await http.get(url, headers: headers);

    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params, Map<String, String> body,) async{
    Uri url = Uri.https(BASEURL, api);
    final response = await http.post(url, headers: headers, body: jsonEncode(body), params: params);

    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params, Map<String, String> body,) async{
    Uri url = Uri.https(BASEURL, api, params);
    final response = await http.put(url, headers: headers, body: jsonEncode(body));

    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, String> params, Map<String, String> body,) async{
    Uri url = Uri.https(BASEURL, api, params);
    final response = await http.patch(url, headers: headers, body: jsonEncode(body));

    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async{
    Uri url = Uri.https(BASEURL, api, params);
    final response = await http.delete(url, headers: headers);

    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> MULTIPART(String api, String filePath, Map<String, String> body) async {
    var uri = Uri.https(BASEURL, api);
    var request = MultipartRequest('POST', uri);
    request.headers.addAll((headersForUpload));
    request.files.add(await MultipartFile.fromPath('file', filePath, contentType: MediaType("image", "jpeg")));
    request.fields.addAll(body);
    StreamedResponse response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase;
    }
  }

  // params
  static Map<String, String> paramsEmpty() {
    Map<String, String> map = {};
    return map;
  }

  static Map<String, String> paramsBreedSearch(String queryName) {
    Map<String, String> map = {
      'q': queryName
    };
    return map;
  }

  static Map<String, String> paramsVotesList({int limit = 10, int page = 0, String? subId}) {
    Map<String, String> map = {
      'limit': limit.toString(),
      'page': page.toString()
    };
    if(subId != null) {
      map.addAll({"sub_id": subId});
    }
    return map;
  }

  // bodies
  static Map<String, String> bodyVotes(String imageId, String subId, int value) {
    Map<String, String> map = {
      "image_id": imageId,
      "sub_id": subId,
      "value": value.toString()
    };
    return map;
  }

  // parsing
}