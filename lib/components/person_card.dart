// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/model/person.dart';
import 'package:flutter_friends_ranking/model/person_list.dart';
import 'package:provider/provider.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({required this.person, required this.index, super.key});
  final Person person;
  final int index;

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              // height: 200,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Center(child: TextField()),
            );
          });
    }

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
                _showSettingsPanel();
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<PersonListModel>().deletePerson(index: index);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
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
