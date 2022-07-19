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

  // headers
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'x-api-key': '19abbefc-b253-4f39-a7ee-769267b6cd56',
  };

  static Map<String, String> headersForUpload = {
    'Content-Type': 'multipart/form-data',
    'x-api-key': '19abbefc-b253-4f39-a7ee-769267b6cd56',
  };

  // interceptor
  static final http = InterceptedHttp.build(interceptors: [
    InterceptorService(),
  ]);

  // methods
  static Future<String?> GET(String api, Map<String, dynamic> params) async{
    Uri url = Uri.https(BASEURL, api, params);
    final response = await http.get(url, headers: headers);

    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params, Map<String, dynamic> body,) async{
    Uri url = Uri.https(BASEURL, api, params);
    final response = await http.post(url, headers: headers, body: body);

    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, dynamic> params, Map<String, dynamic> body,) async{
    Uri url = Uri.https(BASEURL, api, params);
    final response = await http.put(url, headers: headers, body: body);

    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, dynamic> params, Map<String, dynamic> body,) async{
    Uri url = Uri.https(BASEURL, api, params);
    final response = await http.patch(url, headers: headers, body: body);

    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, dynamic> params) async{
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
  static Map<String, dynamic> paramsEmpty() {
    Map<String, dynamic> map = {};
    return map;
  }

  static Map<String, dynamic> paramsBreedSearch(String queryName) {
    Map<String, dynamic> map = {
      'q': queryName
    };
    return map;
  }

  // bodies
  static Map<String, dynamic> bodyVotes(String imageId, String subId, int value) {
    Map<String, dynamic> map = {
      "image_id": imageId,
      "sub_id": subId,
      "value": value
    };
    return map;
  }

  // parsing
}