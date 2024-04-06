import 'dart:typed_data';

class Person {
  final String name;
  final Uint8List? image;
  final String? defaultImage;

  Person(
      {required this.name,
      this.image,
      this.defaultImage = 'assets/default profile.jpg'});
}
