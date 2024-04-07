// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/shared/constants.dart';

class FormSettings extends StatelessWidget {
  const FormSettings(
      {this.image,
      this.friendName,
      this.address,
      this.age,
      this.school,
      this.onTap,
      super.key});
  final Uint8List? image;
  final Function()? onTap;
  final TextEditingController? friendName;
  final TextEditingController? address;
  final TextEditingController? age;
  final TextEditingController? school;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Colors.white,
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
          child: Column(
            children: [
              TextField(
                controller: friendName,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: textInputDecoration.copyWith(
                  hintText: 'Friend\'s name',
                ),
              ),
              TextField(
                controller: address,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: textInputDecoration.copyWith(
                  hintText: 'Friend\'s address',
                ),
              ),
              TextField(
                controller: age,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: textInputDecoration.copyWith(
                  hintText: 'Friend\'s age',
                ),
              ),
              TextField(
                controller: school,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: textInputDecoration.copyWith(
                  hintText: 'Friend\'s school',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
