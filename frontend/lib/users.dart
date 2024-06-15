import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolinventory/appstate.dart';
import 'package:schoolinventory/genericscaffold.dart';
import 'package:schoolinventory/helpers.dart';
import 'package:schoolinventory/itemadd.dart';
import 'package:schoolinventory/usersadd.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<dynamic> _users = [];

  @override
  void initState() {
    fetchUsersData();

    super.initState();
  }

  void fetchUsersData() async {
    final d = await fetchUsers();

    setState(() {
      _users = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      fab: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => UserAddPage(
                        onSave: () async {
                          fetchUsersData();
                        },
                      )));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ...[
                Container(
                  child: Text(
                    'Users',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
              ...(_users.asMap().map((key, value) {
                return MapEntry(
                  key,
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Card(
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => UserAddPage(
                                            id: value?['id'],
                                            onSave: () async {
                                              fetchUsersData();
                                            },
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Text(
                                            '${value?['username'] ?? 'No Username'} - Role: ${value?['role'] ?? 'No Role'}'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              }).values)
            ],
          ),
        ),
      ),
    );
  }
}
