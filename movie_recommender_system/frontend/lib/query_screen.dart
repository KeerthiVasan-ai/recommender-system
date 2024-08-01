import 'package:flutter/material.dart';
import 'package:movie_recommender_system/api.dart';
import 'package:movie_recommender_system/build_button.dart';
import 'package:movie_recommender_system/text_field.dart';

class QueryScreen extends StatefulWidget {
  const QueryScreen({Key? key}) : super(key: key);

  @override
  State<QueryScreen> createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  TextEditingController query = TextEditingController();
  var recommendedMovies = <dynamic>[];

  Future<void> fetchMovie(String queryText) async {
    if (queryText.isNotEmpty) {
      recommendedMovies = await FetchMovieRecommendation().fetchMovie(queryText);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie Recommender System")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BuildTextForm(
                    controller: query,
                    label: "Search the Movie",
                    readOnly: false,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  const SizedBox(height: 16),
                  BuildElevatedButton(
                    actionOnButton: () {
                      fetchMovie(query.text);
                    },
                    buttonText: "Find Recommendation",
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: recommendedMovies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: const Icon(Icons.movie),
                          title: Text("${recommendedMovies[index]}"),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
