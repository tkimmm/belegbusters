import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:belegbusters/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUsers(http.Client client) async {
  final response =
    await client.get('http://192.168.0.233:5001/getusers');

  return compute(parseUsers, response.body);
}

List<User> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

void main() => runApp(DataService());

class DataService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        return Text('RFID : ${users[index].userId.toString()} ${users[index].name} ${users[index].email}');
      },
    );
  }
}
    