import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemAddPage extends StatefulWidget {
  const ItemAddPage({super.key});

  @override
  State<ItemAddPage> createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item'),
        actions: [
          Container(
            child: ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                try {
                  await http.post(Uri.parse('http://localhost:8000/api/items'),
                      headers: {'content-type': 'application/json'},
                      body: jsonEncode({
                        'name': 'testing ${DateTime.now()}',
                      }));
                } catch (e) {
                  print(e);
                }

                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
