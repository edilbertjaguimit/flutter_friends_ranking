import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/model/person.dart';

// This will manage the state using Provider State Management
class PersonListModel extends ChangeNotifier {
  List<Person> persons = [
    Person(
      defaultImage: 'assets/My ID.jpg',
      name: 'Edilbert Cute',
      address: 'Minglanilla, Cebu',
      age: 21,
      school: 'Cebu Technological University',
    ),
    Person(
      defaultImage: 'assets/boy 1.png',
      name: 'Edilbert',
      address: 'Minglanilla, Cebu',
      age: 21,
      school: 'Cebu Technological University',
    ),
    Person(
      defaultImage: 'assets/girl 1.png',
      name: 'Edilbert Crist',
      address: 'Minglanilla, Cebu',
      age: 21,
      school: 'Cebu Technological University',
    ),
  ];

  void addNewPerson({
    required String name,
    required String address,
    required int age,
    required String school,
    Uint8List? image,
  }) {
    persons.add(Person(
        name: name, address: address, age: age, school: school, image: image));
    notifyListeners();
  }

  void deletePerson({required int index}) {
    persons.removeAt(index);
    notifyListeners();
  }

  void updatePerson(
      {required String name,
      required String address,
      required int age,
      required String school,
      Uint8List? image,
      required int index}) {
    persons[index] = Person(
        name: name, address: address, age: age, school: school, image: image);
    notifyListeners();
  }
}
