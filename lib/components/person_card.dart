// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
  Uint8List? _image;
  File? selectedImage;
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
    showModalBottomSheet(
        backgroundColor: Color(0xff9290c3),
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pinckImageFromGallery();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text('Galery'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pinckImageFromCamera();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text('Camera'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _pinckImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.pop(context);
  }

  Future _pinckImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.pop(context);
  }
//   Future _pinckImageFromGallery() async {
//   final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//   if (returnImage == null) return;
//   setState(() {
//     selectedImage = File(returnImage.path);
//   });

//   // Read image bytes asynchronously
//   final bytes = await File(returnImage.path).readAsBytes();
//   setState(() {
//     _image = bytes;
//   });
// }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff9290c3),
      child: ListTile(
        // dense: true,
        // minVerticalPadding: 5,
        leading: CircleAvatar(
          backgroundImage: _image != null
              ? MemoryImage(_image!)
              : AssetImage(widget.person.imageUrl) as ImageProvider<Object>?,
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
            'imageUrl': widget.person.imageUrl,
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
