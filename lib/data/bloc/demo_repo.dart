import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/demo_model.dart';
import '../services/api.dart';
import '../services/base.dart';

class DemoRepository extends BaseRepository {
  final ApiService api;

  DemoRepository({required this.api});

  Future<List<DemoModel>> fetchDemo() async {
    final url = Uri.parse('${api.baseUrl}/api/v1/demo/test');
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> listDemo = jsonDecode(utf8.decode(response.bodyBytes));
      if (listDemo['error_code'] == 0) {
        return (listDemo['result'] as List).map((e) => DemoModel.fromJson(e)).toList();
      } else {
        throw Exception(listDemo['error_message'] ?? 'Unknown error occurred');
      }
    } else {
      throw Exception('Failed to load events: ${response.statusCode}');
    }
  }
}
