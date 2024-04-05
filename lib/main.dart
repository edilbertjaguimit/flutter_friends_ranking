// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_friends_ranking/pages/home_page.dart';
import 'package:flutter_friends_ranking/pages/person_details.dart';

void main() => runApp(const FriendsRankingApp());

class FriendsRankingApp extends StatelessWidget {
  const FriendsRankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
        'personDetails': (context) => PersonDetails(),
      },
    );
  }
}
