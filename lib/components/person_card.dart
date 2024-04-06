// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/components/form.dart';
import 'package:flutter_friends_ranking/model/person.dart';
import 'package:flutter_friends_ranking/model/person_list.dart';
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
  // Uint8List? _image;
  // File? selectedImage;
  final ValueNotifier<Uint8List?> _image = ValueNotifier<Uint8List?>(null);
  TextEditingController friendName = TextEditingController();

  // File? _image;
  // final picker = ImagePicker();
  // Future getImage() async {
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedImage != null) {
  //       _image = File(pickedImage.path);
  //     } else {
  //       print('No Image is Picked');
  //     }
  //   });
  // }

  void _showSettingsPanel(BuildContext context) {
    // _image = widget.
    showModalBottomSheet(
        isDismissible: false,
        elevation: 0,
        backgroundColor: Color(0xff535c91),
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: ValueListenableBuilder<Uint8List?>(
              valueListenable: _image,
              builder: (context, value, child) {
                // _image.value = value;
                friendName.text.isEmpty
                    ? friendName.text = widget.person.name
                    : friendName;
                // widget.person.image != null ? widget.person.image! : value;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: FormSettings(
                          image: value ?? widget.person.image,
                          friendName: friendName,
                          onTap: () => _pickImageFromGallery(),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                context.read<PersonListModel>().updatePerson(
                                      name: friendName.text,
                                      image: value ?? widget.person.image,
                                      index: widget.index,
                                    );
                                Navigator.pop(context);
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
