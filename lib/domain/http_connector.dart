import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final httpConnector = Provider<HttpConnector>((ref){
  return HttpConnector();
});

class HttpConnector {
  final host = "http://localhost:5000";
  final headers = {"content-Type":"application/json; charset=utf-8"}; // headers는 Map타입.
  final Client _client = Client();

  Future<Response> get(String path) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.get(uri);
    return response;
  }

  Future<Response> post(String path, String body) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.post(uri, body:body, headers:headers);
    return response;
  }
}