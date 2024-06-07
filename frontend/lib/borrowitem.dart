import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolinventory/appstate.dart';
import 'package:schoolinventory/borrowitemdetail.dart';
import 'package:schoolinventory/genericscaffold.dart';
import 'package:schoolinventory/helpers.dart';
import 'package:schoolinventory/inventoryadd.dart';
import 'package:schoolinventory/itemadd.dart';

class BorrowItemPage extends StatefulWidget {
  const BorrowItemPage({super.key});

  @override
  State<BorrowItemPage> createState() => _BorrowItemPageState();
}

class _BorrowItemPageState extends State<BorrowItemPage> {
  List<dynamic> _inventory = [];

  @override
  void initState() {
    fetchInventoryData();

    super.initState();
  }

  void fetchInventoryData() async {
    final d = await fetchInventoryList();

    setState(() {
      _inventory = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      // fab: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (_) => InventoryAddPage(
      //                   onSave: () async {
      //                     fetchInventoryData();
      //                   },
      //                 )));
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ...[
                Container(
                  child: Text(
                    'Borrow Item',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
              ...(_inventory.asMap().map((key, value) {
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
                                      builder: (_) => BorrowItemDetailPage(
                                            id: value?['item']['id'],
                                            onSave: () async {
                                              fetchInventoryData();
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
                                      Expanded(
                                        child: Container(
                                          child: Text(value?['item']?['name'] ??
                                              'No Name'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child:
                                              Text('${value?['stock'] ?? 0}'),
                                        ),
                                      ),
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
