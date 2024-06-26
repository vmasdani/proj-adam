import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolinventory/appstate.dart';
import 'package:schoolinventory/genericscaffold.dart';
import 'package:schoolinventory/helpers.dart';
import 'package:schoolinventory/itemadd.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<dynamic> _items = [];

  @override
  void initState() {
    fetchItemsData();

    super.initState();
  }

  void fetchItemsData() async {
    final d = await fetchItems();

    setState(() {
      _items = d;
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
                  builder: (_) => ItemAddPage(
                        onSave: () async {
                          fetchItemsData();
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
                    'Items',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
              ...(_items.asMap().map((key, value) {
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
                                      builder: (_) => ItemAddPage(
                                            id: value?['id'],
                                            onSave: () async {
                                              fetchItemsData();
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
                                        child:
                                            Text(value?['name'] ?? 'No Name'),
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
