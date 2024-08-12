import 'package:flutter_application_1/models/usernames.dart';

class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final String url;
  final UserName name;

  User({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.url,
    required this.name,
  });

  factory User.fromMap(Map<String, dynamic> json) {
    final name = UserName.fromMap(json['name']);
    return User(
      cell: json['cell'],
      email: json['email'],
      gender: json['gender'],
      nat: json['nat'],
      phone: json['phone'],
      url: json['picture']['thumbnail'],
      name: name,
    );
  }

  String get fullName => '${name.first} ${name.last}';
  

  factory User.blankUser(){
    return User(
      cell: ' ',
      email: ' ',
      gender: ' ',
      nat: ' ',
      phone: ' ',
      url: ' ',
      name: UserName(title: '',first: '',last: ''),
    );
  }

}
