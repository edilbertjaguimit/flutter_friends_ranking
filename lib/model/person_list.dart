import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/model/person.dart';

// This will manage the state using Provider State Management
class PersonListModel extends ChangeNotifier {
  List<Person> persons = [
    Person(defaultImage: 'assets/My ID.jpg', name: 'Edilbert Cute'),
    Person(defaultImage: 'assets/boy 1.png', name: 'Jericho'),
    Person(defaultImage: 'assets/girl 1.png', name: 'Keren'),
  ];

  void addNewPerson({required String name, Uint8List? image}) {
    persons.add(Person(name: name, image: image));
    notifyListeners();
  }

  void deletePerson({required int index}) {
    persons.removeAt(index);
    notifyListeners();
  }
}
