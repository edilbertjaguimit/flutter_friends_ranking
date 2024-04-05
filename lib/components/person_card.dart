// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/model/person.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({required this.person, required this.index, super.key});
  final Person person;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff9290c3),
      child: ListTile(
        // dense: true,
        // minVerticalPadding: 5,
        leading: CircleAvatar(
          backgroundImage: AssetImage(person.imageUrl),
          radius: 25,
        ),
        title: Text(
          person.name,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Rank ${index + 1}',
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
        trailing: Icon(
          Icons.visibility,
          color: Colors.white,
        ),
        onTap: () {
          print(index);
          Navigator.pushNamed(context, 'personDetails', arguments: {
            'imageUrl': person.imageUrl,
            'name': person.name,
            'rank': index + 1,
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
