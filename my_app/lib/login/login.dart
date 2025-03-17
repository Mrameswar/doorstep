import 'package:doorstep/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: const Text(
              "Skip",
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60), // Moves the row slightly upward
            Row(
              mainAxisSize: MainAxisSize.min, // Prevents extra space
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/logo1.png',
                    height: 80, // Reduced size for compactness
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8), // Reduced spacing
                const Text(
                  "\n\nFind your Doorstep",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30), // Adjusted spacing after image & text
            IntlPhoneField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              initialCountryCode: 'IN', // Set default country
              onChanged: (phone) {
                print(phone.completeNumber); // Handle phone input
              },
            ),
            const SizedBox(height: 20),

            // Send OTP button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle send OTP
                },
                child: const Text('Send OTP'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle continue with email
                },
                child: const Text('Continue with Email'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}
