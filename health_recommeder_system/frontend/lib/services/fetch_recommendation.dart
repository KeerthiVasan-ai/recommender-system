import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'http://127.0.0.1:5000/recommend';

  Future<Map<String, dynamic>> getRecommendations(double distance, int activeMinutes, int calories) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'distance': distance,
        'active_minutes': activeMinutes,
        'calories': calories,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recommendations');
    }
  }
}
