// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/components/form.dart';
import 'package:flutter_friends_ranking/components/toast.dart';
import 'package:flutter_friends_ranking/model/person.dart';
import 'package:flutter_friends_ranking/model/person_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PersonCard extends StatefulWidget {
  const PersonCard({required this.person, required this.index, super.key});
  final Person person;
  final int index;

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  FToast? fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  final ValueNotifier<Uint8List?> _image = ValueNotifier<Uint8List?>(null);
  // text inputs
  TextEditingController friendName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController school = TextEditingController();

  Future<void> _displayToast({required String message}) async {
    await Future.delayed(Duration(milliseconds: 100), () {
      fToast!.showToast(
        child: MyToast(message: message),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
      );
    });
  }

  void _showSettingsPanel(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        elevation: 0,
        backgroundColor: Color(0xff535c91),
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.2,
            child: ValueListenableBuilder<Uint8List?>(
              valueListenable: _image,
              builder: (context, value, child) {
                friendName.text.isEmpty
                    ? friendName.text = widget.person.name
                    : friendName;
                address.text.isEmpty
                    ? address.text = widget.person.address!
                    : address;
                age.text.isEmpty
                    ? age.text = widget.person.age.toString()
                    : age;
                school.text.isEmpty
                    ? school.text = widget.person.school!
                    : school;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        'Edit Friend\'s Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: FormSettings(
                          image: value ?? widget.person.image,
                          friendName: friendName,
                          address: address,
                          age: age,
                          school: school,
                          onTap: () => _pickImageFromGallery(),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (friendName.text.isNotEmpty) {
                                  // Update the person details
                                  context.read<PersonListModel>().updatePerson(
                                        name: friendName.text,
                                        address: address.text,
                                        age: int.parse(age.text),
                                        school: school.text,
                                        image: value ?? widget.person.image,
                                        index: widget.index,
                                      );
                                  _displayToast(message: 'Saved Successfully');
                                  Navigator.pop(context);
                                } else {
                                  _displayToast(message: 'Field is required');
                                }
                              },
                              child: Text('Save')),
                          SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image.value = await pickedFile.readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    // var personList = context.watch<PersonListModel>().persons;

    return Card(
      color: Color(0xff9290c3),
      child: ListTile(
        // dense: true,
        // minVerticalPadding: 5,
        leading: CircleAvatar(
          backgroundImage: widget.person.image != null
              ? MemoryImage(widget.person.image!)
              : AssetImage(widget.person.defaultImage!)
                  as ImageProvider<Object>?,
          radius: 25,
        ),
        title: Text(
          widget.person.name,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Rank ${widget.index + 1}',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        // isThreeLine: true,
        // contentPadding: EdgeInsets.all(0),
        // minLeadingWidth: ,
        // tileColor: Colors.amber,
        dense: true,
        // contentPadding:
        //     EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(
            //   Icons.visibility,
            //   color: Colors.white,
            // ),
            IconButton(
              onPressed: () {
                // context.read<PersonListModel>().deletePerson(index: index);
                _showSettingsPanel(context);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                context
                    .read<PersonListModel>()
                    .deletePerson(index: widget.index);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
        onTap: () {
          print(widget.index);
          Navigator.pushNamed(context, 'personDetails', arguments: {
            'imageUrl':
                widget.person.image == null ? widget.person.defaultImage : null,
            'image': widget.person.image,
            'name': widget.person.name,
            'address': widget.person.address,
            'age': widget.person.age,
            'school': widget.person.school,
            'rank': widget.index + 1,
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
