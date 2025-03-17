import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:doorstep/plumber/plumberdashbord.dart';
import 'package:doorstep/plumber/plumberuserController.dart';

class RegisterPlumberScreen extends StatefulWidget {
  const RegisterPlumberScreen({super.key});

  @override
  _RegisterPlumberScreenState createState() => _RegisterPlumberScreenState();
}

class _RegisterPlumberScreenState extends State<RegisterPlumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expertiseController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _selectedImage;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _registerPlumber() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      String name = _nameController.text.trim();
      String expertise = _expertiseController.text.trim();
      String location = _locationController.text.trim();
      int experience = int.tryParse(_experienceController.text.trim()) ?? 0;
      int price = int.tryParse(_priceController.text.trim()) ?? 0;

      bool success = await PlumberUserController.addPlumber(
        name: name,
        expertise: expertise,
        experience: experience,
        location: location,
        price: price,
        imageFile: _selectedImage,
      );

      setState(() => _isLoading = false);

      if (success) {
        Fluttertoast.showToast(
            msg: "Plumber registered successfully!",
            backgroundColor: Colors.green);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlumberDashboardScreen(
              name: name,
              expertise: expertise,
              experience: experience.toString(),
              location: location,
              price: price.toString(),
              imageUrl: _selectedImage,
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Registration failed. Please try again.",
            backgroundColor: Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register as Plumber"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFFDFF6D9),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Create Your Profile",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Profile Picture Upload
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null,
                      child: _selectedImage == null
                          ? const Icon(Icons.camera_alt,
                              size: 40, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Input Fields
                  _buildTextField("Name", _nameController),
                  _buildTextField("Expertise", _expertiseController),
                  _buildTextField("Experience (years)", _experienceController,
                      isNumber: true),
                  _buildTextField("Location", _locationController),
                  _buildTextField("Price", _priceController, isNumber: true),

                  const SizedBox(height: 20),

                  // Register Button
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _registerPlumber,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
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

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label is required";
          }
          return null;
        },
      ),
    );
  }
}
