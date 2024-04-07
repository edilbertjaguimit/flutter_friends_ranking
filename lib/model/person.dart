import 'dart:typed_data';

class Person {
  final String name;
  final String? address;
  final int? age;
  final String? school;
  final Uint8List? image;
  final String? defaultImage;

  Person({
    required this.name,
    this.address,
    this.age,
    this.school,
    this.image,
    this.defaultImage = 'assets/default profile.jpg',
  });
}
