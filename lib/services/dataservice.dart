import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUsers(http.Client client) async {
  final response =
    await client.get('http://192.168.0.233:5001/getusers');

  return compute(parseUsers, response.body);
}

class User {
  final int userId;
  final String name;
  final String surname;
  final String location;
  final String email;
  final String phone_1;
  final String phone_2;

  User({this.name, this.surname, this.location, this.email, this.phone_1, this.phone_2, this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      surname: json['surname'] as String,
      location: json['location'] as String,
      email: json['email'] as String,
      phone_1: json['phone_1'] as String,
      phone_2: json['phone_2'] as String,
      userId: json['user_id'] as int,
    );
  }
}

List<User> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

void main() => runApp(DataService());

class DataService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final appTitle = 'Isolate Demo';

    return DataServiceRes();
  }
}

class DataServiceRes extends StatelessWidget {
  final int userid;

  DataServiceRes({Key key, this.userid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: fetchUsers(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? UserList(users: snapshot.data)
              : Center(child: CircularProgressIndicator(
                backgroundColor: Colors.orange,
              ));
        },
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final List<User> users;

  UserList({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: users.length,
        itemBuilder: (context, index) {
        if (index == 0){
          return Text('Postgres DB API REST Call (users table)', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold));
        }
        return Text(index.toString() + " " + "RFID: " + users[index].userId.toString() + " " + users[index].name + " " + users[index].email);
      },
    );
  }
}
    