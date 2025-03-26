import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  ApiService(this._client);

  static const String baseUrl = 'https://fakestoreapi.com';
  final http.Client _client;

  Future<List<dynamic>> fetchProducts() async {
    final response = await _client.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    }
    throw Exception('Failed to load products');
  }
}
