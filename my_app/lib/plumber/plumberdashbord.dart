import 'package:flutter/material.dart';
import 'dart:io';

class PlumberDashboardScreen extends StatefulWidget {
  final String name;
  final String expertise;
  final String experience;
  final String location;
  final String price;
  final File? imageUrl;

  const PlumberDashboardScreen({
    super.key,
    required this.name,
    required this.expertise,
    required this.experience,
    required this.location,
    required this.price,
    this.imageUrl,
  });

  @override
  _PlumberDashboardScreenState createState() => _PlumberDashboardScreenState();
}

class _PlumberDashboardScreenState extends State<PlumberDashboardScreen> {
  late String name;
  late String expertise;
  late String experience;
  late String location;
  late String price;
  File? imageUrl;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    expertise = widget.expertise;
    experience = widget.experience;
    location = widget.location;
    price = widget.price;
    imageUrl = widget.imageUrl;
  }

  void _editProfile() {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController expertiseController =
        TextEditingController(text: expertise);
    TextEditingController experienceController =
        TextEditingController(text: experience);
    TextEditingController locationController =
        TextEditingController(text: location);
    TextEditingController priceController = TextEditingController(text: price);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField("Name", nameController),
                _buildTextField("Expertise", expertiseController),
                _buildTextField("Experience", experienceController),
                _buildTextField("Location", locationController),
                _buildTextField("Price", priceController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  expertise = expertiseController.text;
                  experience = experienceController.text;
                  location = locationController.text;
                  price = priceController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _deleteProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Profile"),
          content: const Text(
              "Are you sure you want to delete your profile? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                    context, (route) => route.isFirst); // Go back to home
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child:
                  const Text("Delete", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plumber Dashboard"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: _editProfile,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: _deleteProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        imageUrl != null ? FileImage(imageUrl!) : null,
                    child: imageUrl == null
                        ? const Icon(Icons.person,
                            size: 50, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    expertise,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _infoCard("Experience", "$experience years"),
            _infoCard("Location", location),
            _infoCard(
                "Price per min", "₹${double.parse(price).toStringAsFixed(2)}"),
            _infoCard("Total Earnings", "₹0 (No bookings yet)"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Logout",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
        leading: const Icon(Icons.info, color: Colors.green),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
