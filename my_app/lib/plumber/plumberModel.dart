class Plumber {
  final int id;
  final String name;
  final String expertise;
  final String experience;
  final String location;
  final double rating; // Ensure this is double
  final double price; // Ensure this is double
  final String imageUrl;

  Plumber({
    required this.id,
    required this.name,
    required this.expertise,
    required this.experience,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
  });

  factory Plumber.fromJson(Map<String, dynamic> json) {
    return Plumber(
      id: json['id'] as int,
      name: json['name'] as String,
      expertise: json['expertise'] as String,
      experience: json['experience'] as String,
      location: json['location'] as String,
      rating:
          double.tryParse(json['rating'].toString()) ?? 0.0, // Safe conversion
      price:
          double.tryParse(json['price'].toString()) ?? 0.0, // Safe conversion
      imageUrl: "assets/plumber.png",
    );
  }
}
