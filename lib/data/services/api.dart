import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<String> fetchTest(String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/test'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['test'];
    } else {
      throw Exception('Failed to fetch test data');
    }
  }
}
