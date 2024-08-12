import 'dart:convert';
import 'package:flutter_application_1/models/users.dart';
import 'package:http/http.dart' as http;

class UserApi{

  static Future<List<User>> fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final responce = await http.get(uri);
    final body = responce.body;
    final j = jsonDecode(body);
    final results = j['results'] as List<dynamic>;
    final users = results.map((json) {
      return User.fromMap(json);
    }).toList();
    return users;
  }
}