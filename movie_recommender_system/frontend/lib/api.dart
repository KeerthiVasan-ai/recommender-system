import "dart:convert";
import "package:http/http.dart" as http;
import "dart:developer" as dev;

class FetchMovieRecommendation {
  Future<List<dynamic>> fetchMovie(String query) async {
    const api = 'http://127.0.0.1:5000/recommend';
    try {
      final url = Uri.parse(api);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "movie": query,
        }),
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        List<dynamic> recommendedMovies = result["recommended_movie"];
        dev.log(recommendedMovies.toString());
        return recommendedMovies;
      } else {
        dev.log("Failed to fetch recommendations. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      dev.log(e.toString());
      return [];
    }
  }
}