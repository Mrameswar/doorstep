import 'dart:convert';
import 'dart:io';
import 'package:doorstep/plumber/plumberModel.dart';
import 'package:http/http.dart' as http;

class PlumberUserController {
  Future<List<Plumber>> fetchPlumbers() async {
    final url = Uri.parse('https://astrokumbha.com/api/getPlumbers');
    print("Fetching plumbers from: $url");

    try {
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode({}) // Send an empty JSON body if needed
          );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          List<dynamic> plumberList = data['recordList'];
          print("Plumber list count: ${plumberList.length}");
          return plumberList.map((json) => Plumber.fromJson(json)).toList();
        } else {
          print("API returned error message: ${data['message']}");
          throw Exception(data['message'] ?? "Unknown error occurred");
        }
      } else {
        throw Exception(
            "Failed to load plumbers. Server error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching plumbers: $error");
      throw Exception("Error fetching plumbers: $error");
    }
  }

  //add plumber

  // static Future<bool> addPlumber({
  //   required String name,
  //   required String expertise,
  //   required int experience,
  //   required String location,
  //   required int price,
  //   File? imageFile,
  // }) async {
  //   final url = Uri.parse('https://astrokumbha.com/api/addplumber');
  //   print("Sending plumber details to: $url");

  //   try {
  //     var request = http.MultipartRequest('POST', url);
  //     request.fields.addAll({
  //       "name": "eswarnaik",
  //       "expertise": "Leakage Repair, Pipe Fixing",
  //       "experience": "5 years",
  //       "location": "Mumbai",
  //       "price": "4.7",
  //       "image_url": "assets/plumber1.png"
  //     });

  //     var response = await request.send();
  //     var responseData = await response.stream.bytesToString();
  //     final data = jsonDecode(responseData);

  //     print("Response: $data");

  //     if (response.statusCode == 201 && data['success'] == true) {
  //       return true;
  //     } else {
  //       throw Exception(data['message'] ?? "Registration failed");
  //     }
  //   } catch (error) {
  //     print("Error adding plumber: $error");
  //     return false;
  //   }
  // }
  static Future<bool> addPlumber({
    required String name,
    required String expertise,
    required int experience,
    required String location,
    required int price,
    File? imageFile,
  }) async {
    final url = Uri.parse('https://astrokumbha.com/api/addplumber');
    print("Sending plumber details to: $url");

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({
        "name": name,
        "expertise": expertise,
        "experience": "$experience years",
        "location": location,
        "price": "$price",
        "image_url": "assets/plumber1.png"
      });

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData);

      print("Response: $data");

      if (response.statusCode == 201 && data['success'] == true) {
        return true;
      } else {
        throw Exception(data['message'] ?? "Registration failed");
      }
    } catch (error) {
      print("Error adding plumber: $error");
      return false;
    }
  }
}
