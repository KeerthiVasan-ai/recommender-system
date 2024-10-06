import 'package:flutter/material.dart';
import "dart:developer" as dev;
import '../services/fetch_recommendation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController activeMinutesController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  String activityLevel = '';
  List<String> recommendations = [];

  String getWelcomeMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  void getRecommendation() async {
    double distance = double.tryParse(distanceController.text) ?? 0;
    int activeMinutes = int.tryParse(activeMinutesController.text) ?? 0;
    int calories = int.tryParse(caloriesController.text) ?? 0;

    ApiService apiService = ApiService();
    try {
      final result = await apiService.getRecommendations(
          distance, activeMinutes, calories);
      setState(() {
        var activityLevelNum = result['activity_level'];
        if (activityLevelNum == 1) {
          activityLevel = "Low";
        } else if (activityLevelNum == 2) {
          activityLevel = "Moderate";
        } else if (activityLevelNum == 3) {
          activityLevel = "High";
        } else if (activityLevelNum == 4) {
          activityLevel = "Very High";
        }
        recommendations = List<String>.from(result['recommendations']);
      });
    } catch (e) {
      dev.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Health Recommender System',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getWelcomeMessage(),
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
              const SizedBox(height: 20),
              Text(
                "Let's find the best activity level for you!",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: distanceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Distance (km)',
                          border: OutlineInputBorder(),
                          prefixIcon:
                              Icon(Icons.directions_walk, color: Colors.teal),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: activeMinutesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Active Minutes',
                          border: OutlineInputBorder(),
                          prefixIcon:
                              Icon(Icons.access_time, color: Colors.teal),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: caloriesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Calories Burned',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.local_fire_department,
                              color: Colors.teal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: getRecommendation,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.white54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Get Recommendation',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              if (activityLevel.isNotEmpty)
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended Activity Level for New User: $activityLevel',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Recommended Activities for $activityLevel Activity Level:',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...recommendations.map(
                          (activity) => ListTile(
                            leading:
                                const Icon(Icons.check, color: Colors.green),
                            title: Text(activity),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
