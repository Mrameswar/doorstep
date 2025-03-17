import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  // Controllers to store text field values
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  // State variable to track email sending
  bool _isSending = false;

  Future<void> sendEmailAndContactUs(
      String name, String email, String message) async {
    final smtpServer = SmtpServer(
      'smtp.gmail.com',
      username: 'bigelram9100@gmail.com',
      password: 'wkgt zrel kfaq ujcn',
    );

    final adminMessage = Message()
      ..from =
          const Address('bigelram9100@gmail.com', 'Astrokumbha Contact Form')
      ..recipients.add('bigelram9100@gmail.com')
      ..headers['Reply-To'] = "$email"
      ..subject = 'New Message from Contact Us Form'
      ..text = 'Name: $name\nEmail: $email\nMessage: $message'
      ..html = '''
      <h1>New Message from Contact Us Form</h1>
      <p><strong>Name:</strong> $name</p>
      <p><strong>Email:</strong> $email</p>
      <p><strong>Message:</strong> $message</p>
    ''';
    final userMessage = Message()
      ..from = const Address('bigelram9100@gmail.com', 'Astrokumbha Support')
      ..recipients.add(email)
      ..subject = 'Thank You for Contacting Us'
      ..text =
          'Dear $name,\n\nThank you for reaching out to us. We have received your message and will get back to you shortly.\n\nBest Regards,\nAstrokumbha Support Team'
      ..html = '''
      <h2>Dear $name,</h2>
      <p>Thank you for reaching out to us. We have received your message and will get back to you shortly.</p>
      <p>Best Regards,<br><strong>Astrokumbha Support Team</strong></p>
    ''';

    final url = Uri.parse('/sendMessage');

    try {
      setState(() {
        _isSending = true;
      });

      // Send contact form to server
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"name": name, "email": email, "message": message}),
      );

      if (response.statusCode == 200) {
        // Send admin email
        await send(adminMessage, smtpServer);

        // Send user email
        await send(userMessage, smtpServer);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message sent successfully!')),
        );
        _nameController.clear();
        _emailController.clear();
        _feedbackController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to send message. Please try again later.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while sending message: $e')),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  // Function to show the feedback dialog
  void _showFeedbackDialog() {
    String name = _nameController.text;
    String email = _emailController.text;
    String message = _feedbackController.text;

    sendEmailAndContactUs(name, email, message);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              const Text(
                'I Am Your Service Provider!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Share your feedback and help us improve our app',
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
            ],
          ).paddingAll(15),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField('Full name', 'Enter your name',
                      controller: _nameController),
                  const SizedBox(height: 20),
                  _buildTextField('Email Address', 'Enter your email id',
                      controller: _emailController),
                  const SizedBox(height: 20),
                  _buildTextField('Your Feedback', 'Enter your feedback',
                      controller: _feedbackController, maxLines: 5),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSending ? null : _showFeedbackDialog,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: _isSending
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Submit',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {int maxLines = 1, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontWeight: FontWeight.normal),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.grey[400]!), // Set your desired color here
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.white), // Set your desired color here
            ),
            filled: true,
          ),
        ),
      ],
    );
  }
}
