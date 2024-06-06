import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:schoolinventory/helpers.dart';

class ItemAddPage extends StatefulWidget {
  const ItemAddPage({super.key, this.onSave, this.id});

  final Function? onSave;
  final dynamic? id;

  @override
  State<ItemAddPage> createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  var _nameController = TextEditingController();

  dynamic _item = {};

  @override
  void initState() {
    fetchItemData();
    super.initState();
  }

  Future fetchItemData() async {
    if (widget.id != null) {
      final d = await fetchItem(widget.id);

      setState(() {
        _item = d;
        _nameController.text = d?['name'];
      });
    }
  }

  Future handleSave() async {
    try {
      await http.post(Uri.parse('${dotenv.get('BASE_URL')}/api/items'),
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
        title: Text('Item ${widget.id}'),
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
                _item['name'] = v;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            )
          ],
        ),
      ),
    );
  }
}
