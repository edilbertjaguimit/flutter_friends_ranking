// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:typed_data';

import 'package:flutter/material.dart';

class FormSettings extends StatelessWidget {
  const FormSettings({this.image, this.friendName, this.onTap, super.key});
  final Uint8List? image;
  final Function()? onTap;
  final TextEditingController? friendName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onTap,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: image != null
                      ? MemoryImage(image!)
                      : AssetImage('assets/default profile.jpg')
                          as ImageProvider<Object>?,
                  radius: 25,
                  // child: null,
                ),
                image == null
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.add_a_photo,
                          size: 20,
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: TextField(
            controller: friendName,
            decoration: InputDecoration(hintText: 'Friend\'s name'),
          ),
        ),
      ],
    );
  }
}
