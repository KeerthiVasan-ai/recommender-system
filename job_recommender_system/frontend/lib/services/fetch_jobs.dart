import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchJobRecommendations(String jobTitle) async {
  const String url = 'http://127.0.0.1:5000/recommend';

  final Map<String, dynamic> payload = {
    'title': jobTitle,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load recommendations: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
