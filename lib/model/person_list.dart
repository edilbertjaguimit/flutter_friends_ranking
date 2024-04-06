import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/model/person.dart';

// This will manage the state using Provider State Management
class PersonListModel extends ChangeNotifier {
  List<Person> persons = [
    const Person(imageUrl: 'assets/My ID.jpg', name: 'Edilbert Cute'),
    const Person(imageUrl: 'assets/boy 1.png', name: 'Jericho'),
    const Person(imageUrl: 'assets/girl 1.png', name: 'Keren'),
  ];

  void addNewPerson({required String name}) {
    persons.add(Person(imageUrl: 'assets/default profile.jpg', name: name));
    notifyListeners();
  }

  void deletePerson({required int index}) {
    persons.removeAt(index);
    notifyListeners();
  }
}
