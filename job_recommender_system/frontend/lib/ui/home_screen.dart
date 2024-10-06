import 'package:flutter/material.dart';
import 'package:frontend/model/data_warehouse.dart';
import 'package:frontend/services/fetch_jobs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<String> filteredJobTitles = [];
  List<Map<String, dynamic>> recommendedJobs = [];
  bool isLoading = false; // Loading indicator

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _filterJobTitles();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterJobTitles() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      filteredJobTitles = DataWareHouse()
          .jobTitles
          .where((jobTitle) => jobTitle.toLowerCase().contains(query))
          .toList();
    });
  }

  void _searchJob(String selectedJobTitle) async {
    setState(() {
      isLoading = true; // Start loading
    });

    _searchController.text = selectedJobTitle;
    recommendedJobs = await fetchJobRecommendations(selectedJobTitle);

    setState(() {
      isLoading = false; // Stop loading
      filteredJobTitles.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Recommendation System'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a job title...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: const Icon(Icons.search),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear(); // Clear the search text
                    setState(() {
                      filteredJobTitles.clear(); // Clear filtered job titles
                      recommendedJobs.clear(); // Clear recommendations
                    });
                  },
                ),
              ),
            ),
            if (filteredJobTitles.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: filteredJobTitles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          filteredJobTitles[index],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () => _searchJob(filteredJobTitles[index]),
                      ),
                    );
                  },
                ),
              )
            else
              const SizedBox.shrink(),
            const SizedBox(height: 20),
            // Display the recommendations after a job title is selected
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : recommendedJobs.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.info_outline,
                                  size: 50, color: Colors.grey),
                              const SizedBox(height: 10),
                              Text(
                                'No recommendations yet. Try searching for a job!',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: recommendedJobs.length,
                          itemBuilder: (context, index) {
                            var job = recommendedJobs[index];
                            return Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(
                                  job['Job Title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Experience: ${job['Job Experience Required']}\nSkills: ${job['Key Skills']}',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
