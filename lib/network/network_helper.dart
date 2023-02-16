import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkHelper {
  Future<http.Response> get(String endpoint) async {
    try {
      var url = Uri.parse(endpoint);
      var response = await http.get(url).timeout(const Duration(seconds: 30));
      return response;
    }
    on TimeoutException catch (_) {
      var url = Uri.parse(endpoint);
      var response = await http.get(url);
      return response;
    }
    on SocketException catch (_) {
      var url = Uri.parse(endpoint);
      var response = await http.get(url);
      return response;
    }
  }
}
