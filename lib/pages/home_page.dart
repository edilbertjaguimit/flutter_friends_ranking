// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/components/person_card.dart';
import 'package:flutter_friends_ranking/components/toast.dart';
import 'package:flutter_friends_ranking/model/person_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FToast? fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  TextEditingController friendName = TextEditingController();
  // List<Person> personList = [
  //   const Person(imageUrl: 'assets/My ID.jpg', name: 'Edilbert Cute'),
  //   const Person(imageUrl: 'assets/boy 1.png', name: 'Jericho'),
  //   const Person(imageUrl: 'assets/girl 1.png', name: 'Keren'),
  // ];
  // PersonListModel personList = PersonListModel();

  Future<void> _displayToast() async {
    await Future.delayed(Duration(milliseconds: 100), () {
      fToast!.showToast(
        child: MyToast(message: 'Added Successfully'),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
      );
    });
  }

  Future<void> _displayAddDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          title: Text('Add new friend'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: friendName,
                  decoration: InputDecoration(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (friendName.text.isNotEmpty) {
                  setState(() {
                    // personList.add(Person(
                    //     imageUrl: 'assets/default profile.jpg',
                    //     name: friendName.text));
                    // personList.addNewPerson(friendName.text);
                    // personList.personList();
                    context
                        .read<PersonListModel>()
                        .addNewPerson(name: friendName.text);
                  });
                  print(friendName.text);
                  friendName.text = '';
                  Navigator.pop(context);
                  _displayToast();
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var personList = context.watch<PersonListModel>().persons;
    print(personList);
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
        onPressed: () {
          _displayAddDialog();
        },
        backgroundColor: Color(0xff9290c3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
