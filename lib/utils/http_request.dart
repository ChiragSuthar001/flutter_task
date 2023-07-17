import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseURL = "dummyjson.com";

Future<Map<String, dynamic>> getData(
  String endpoint, {
  Map<String, dynamic>? query,
  int pageNumber = 1,
}) async {
  final url = Uri(
    scheme: 'https',
    host: baseURL,
    path: endpoint,
    queryParameters: {
      "limit": '10',
      "skip": '${(pageNumber - 1) * 10}',
      if (query != null) ...query,
    },
  );

  final response = await http.get(
    url,
    headers: {
      'content-type': 'application/json',
    },
  );

  final result = json.decode(response.body);

  return result;
}

Future<Map<String, dynamic>> postData(
    String endpoint, Map<String, dynamic> data) async {
  final url = Uri.https(baseURL, endpoint);

  final response = await http.post(
    url,
    headers: {
      'content-type': 'application/json',
    },
    body: json.encode(data),
  );

  final result = json.decode(response.body);

  return result as Map<String, dynamic>;
}
