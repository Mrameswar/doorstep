import 'package:doorstep/FeedbackForm.dart';
import 'package:doorstep/bottomnavigation.dart';
import 'package:doorstep/cartpage.dart';
import 'package:doorstep/cleaning/CleaningScreen.dart';
import 'package:doorstep/custom.dart';
import 'package:doorstep/electrician/ElectricianScreen.dart';
import 'package:doorstep/housesearch/HouseSearchScreen.dart';
import 'package:doorstep/plumber/plumberscreen.dart';
import 'package:doorstep/profilepage.dart';
import 'package:doorstep/pujari/PujariScreen.dart';
import 'package:doorstep/repair/RepairScreen.dart';
import 'package:doorstep/sidemenu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track selected tab

  final List<Widget> _pages = [
    const HomePage(),
    SearchPage(),
    CartPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title:
            const Text('DoorstepEase', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: SideMenu(), // Attach Side Menu
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// **Home Page**
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // **Search Bar**
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for services...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // **Circular Service Buttons**
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Popular Services",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _serviceButton("assets/plumber.png", "Plumber",
                    const PlumberScreen(), context),
                _serviceButton("assets/cleaning.png", "Cleaning",
                    CleaningScreen(), context),
                _serviceButton("assets/electric.png", "Electrician",
                    ElectricianScreen(), context),
                _serviceButton(
                    "assets/pujari.png", "Pujari", PujariScreen(), context),
                _serviceButton(
                    "assets/repair.png", "Repair", RepairScreen(), context),
                _serviceButton("assets/home.png", "House Search",
                    HouseSearchScreen(), context),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Looking for a house?",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Text("Find a perfect place near you!",
                          style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HouseSearchScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Search Now",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/home.png',
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // **Special Offers / Discounts**
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Special Offers",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _offerCard("20% Off on Cleaning Services", "assets/offer.png"),
                _offerCard("Get ₹100 Off on Plumbing", "assets/offer.png"),
                _offerCard(
                    "Limited Time Electrician Discounts", "assets/offer.png"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // **Top Service Providers Section**
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Top Service Providers",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 120, // Increased height to avoid overflow
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _topProvider("John Doe", "Plumber", "assets/pl.jpg"),
                _topProvider("Rahul Sharma", "Electrician", "assets/ele.jpeg"),
                _topProvider(
                    "Priya Sen", "House Cleaning", "assets/housecl.jpge"),
              ],
            ),
          ),

          const SizedBox(height: 20),
          FeedbackForm(),
        ],
      ),
    );
  }

  // **Circular Service Button Widget**
  Widget _serviceButton(
      String imagePath, String title, Widget screen, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // **Offer Card Widget**
  Widget _offerCard(String title, String imagePath) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(left: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imagePath,
                width: 230, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(height: 5),
          Text(title,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // **Top Service Provider Card**
  Widget _topProvider(String name, String profession, String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(left: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 25, backgroundImage: AssetImage(imagePath)),
          const SizedBox(height: 5),
          Text(name,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Text(profession,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}
