import 'package:doorstep/plumber/plumberModel.dart';
import 'package:doorstep/plumber/plumberuserController.dart';
import 'package:flutter/material.dart';

class PlumberUsersScreen extends StatefulWidget {
  const PlumberUsersScreen({super.key});

  @override
  _PlumberUsersScreenState createState() => _PlumberUsersScreenState();
}

class _PlumberUsersScreenState extends State<PlumberUsersScreen> {
  List<Plumber> plumbers = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchPlumbers();
  }

  Future<void> fetchPlumbers() async {
    try {
      List<Plumber> fetchedPlumbers =
          await PlumberUserController().fetchPlumbers();
      setState(() {
        plumbers = fetchedPlumbers;
        isLoading = false;
        errorMessage = "";
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load plumbers. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plumbers Near You'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 16)))
              : ListView.builder(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: plumbers.length,
                  itemBuilder: (context, index) {
                    return _plumberCard(
                      name: plumbers[index].name,
                      expertise: plumbers[index].expertise,
                      experience: plumbers[index].experience,
                      location: plumbers[index].location,
                      rating: plumbers[index].rating,
                      price: plumbers[index].price,
                      imageUrl: plumbers[index].imageUrl,
                    );
                  },
                ),
    );
  }

  Widget _plumberCard({
    required String name,
    required String expertise,
    required String experience,
    required String location,
    required double rating,
    required double price,
    required String imageUrl,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: Colors.blue, size: 16),
                    ],
                  ),
                  Text(expertise,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text("Experience: $experience",
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text("Location: $location",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.green)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text("$rating", style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 12),
                      Text(
                        "₹$price/min",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Handle chat functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child:
                  const Text("Connect", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
