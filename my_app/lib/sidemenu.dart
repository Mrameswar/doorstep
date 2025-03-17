import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_circle, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text("Welcome, User",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                Text("user@example.com",
                    style: TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ),
          _menuItem(Icons.home, "Home", () {
            Navigator.pop(context);
          }),
          _menuItem(Icons.person, "Profile", () {
            Navigator.pop(context);
            // Navigate to Profile Screen (Replace with actual screen)
          }),
          _menuItem(Icons.settings, "Settings", () {
            Navigator.pop(context);
          }),
          _menuItem(Icons.help, "Help & Support", () {
            Navigator.pop(context);
          }),
          const Divider(),
          _menuItem(Icons.logout, "Logout", () {
            // Add logout functionality
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      onTap: onTap,
    );
  }
}
