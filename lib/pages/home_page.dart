import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/components/person_card.dart';
import 'package:flutter_friends_ranking/model/person.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Person> personList = [
    const Person(imageUrl: 'assets/My ID.jpg', name: 'Edilbert Cute'),
    const Person(imageUrl: 'assets/boy 1.png', name: 'Jericho'),
    const Person(imageUrl: 'assets/girl 1.png', name: 'Keren'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Friends Ranking App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff535c91),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child: ListView.builder(
            itemCount: personList.length,
            itemBuilder: (context, index) =>
                PersonCard(person: personList[index], index: index),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
        child: const Icon(Icons.add),
      ),
    );
  }
}
