import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:schoolinventory/helpers.dart';

class UserAddPage extends StatefulWidget {
  const UserAddPage({super.key, this.onSave, this.id});

  final Function? onSave;
  final dynamic? id;

  @override
  State<UserAddPage> createState() => _UserAddPageState();
}

class _UserAddPageState extends State<UserAddPage> {
  var _nameController = TextEditingController();

  dynamic _item = {};

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  Future fetchUserData() async {
    if (widget.id != null) {
      final d = await fetchUser(widget.id);

      setState(() {
        _item = d;
        _nameController.text = d?['username'];
      });
    }
  }

  Future handleSave() async {
    try {
      await http.post(Uri.parse('${dotenv.get('BASE_URL')}/api/users'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode(_item));
    } catch (e) {
      print(e);
    }

    Navigator.pop(context);
    widget?.onSave?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User ${widget.id}'),
        actions: [
          Container(
            child: ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                handleSave();
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              onChanged: (v) {
                _item['username'] = v;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
            ),
            Container(
              child: Text("Role: ${_item?['role']}"),
            ),
            Container(
                child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      child: Text('Admin'),
                      onPressed: () {
                        setState(() {
                          _item?['role'] = 'Admin';
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      child: Text('Staff'),
                      onPressed: () {
                        setState(() {
                          _item?['role'] = 'Staff';
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      child: Text('User'),
                      onPressed: () {
                        setState(() {
                          _item?['role'] = 'User';
                        });
                      },
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
