// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/components/form.dart';
import 'package:flutter_friends_ranking/components/person_card.dart';
import 'package:flutter_friends_ranking/components/toast.dart';
import 'package:flutter_friends_ranking/model/person_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Uint8List? _image;
  final ValueNotifier<Uint8List?> _image = ValueNotifier<Uint8List?>(null);

  File? selectedImage;
  FToast? fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image.value = await pickedFile.readAsBytes();
    }
  }

  TextEditingController friendName = TextEditingController();
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
                ValueListenableBuilder<Uint8List?>(
                  valueListenable: _image,
                  builder: (context, value, child) {
                    return FormSettings(
                      image: value,
                      friendName: friendName,
                      onTap: () => _pickImageFromGallery(),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (friendName.text.isNotEmpty) {
                  setState(() {
                    context.read<PersonListModel>().addNewPerson(
                        name: friendName.text, image: _image.value);
                  });
                  print(friendName.text);
                  friendName.text = '';
                  Navigator.pop(context);
                  _displayToast();
                  _image.value = null;
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _image.value = null;
                friendName.text = '';
              },
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
