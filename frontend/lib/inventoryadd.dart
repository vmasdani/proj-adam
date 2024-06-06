import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:schoolinventory/helpers.dart';
import 'package:collection/collection.dart';

class InventoryAddPage extends StatefulWidget {
  const InventoryAddPage({super.key, this.onSave, this.id});

  final Function? onSave;
  final dynamic? id;

  @override
  State<InventoryAddPage> createState() => _InventoryAddPageState();
}

class _InventoryAddPageState extends State<InventoryAddPage> {
  var _nameController = TextEditingController();

  dynamic _item = {};

  @override
  void initState() {
    fetchInventoryData();
    super.initState();
  }

  String _selectedInOutType = 'in';
  var _qtyController = TextEditingController(text: '0');
  var _qty = 0.0;

  Future fetchInventoryData() async {
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
      await http.post(Uri.parse('${dotenv.get('BASE_URL')}/api/transactions'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode({
            'item_id': widget.id,
            'in_out_type': _selectedInOutType,
            'qty': _qty,
          }));
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Text('${_item?['name']}'),
              ),
              Container(
                child: Text(
                    'Remaining stock: ${calculateStock(_item?['transactions'] ?? [])}'),
              ),
              Divider(),
              Container(
                child: Text('Manual Add'),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: ElevatedButton(
                        child: Text('in'),
                        onPressed: () {
                          setState(() {
                            _selectedInOutType = 'in';
                          });
                        },
                      ),
                    )),
                    Expanded(
                        child: Container(
                      child: ElevatedButton(
                        child: Text('out'),
                        onPressed: () {
                          setState(() {
                            _selectedInOutType = 'out';
                          });
                        },
                      ),
                    )),
                    Expanded(
                        child: Container(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Qty..'),
                        controller: _qtyController,
                        onChanged: (v) {
                          final d = double.tryParse(v);

                          if (d != null) {
                            setState(() {
                              _qty = d;
                            });
                          }
                        },
                      ),
                    )),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text('Selected in/out: '),
                  ),
                  Container(
                    child: Text(
                      '${_selectedInOutType}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(', qty: '),
                  ),
                  Container(
                    child: Text(
                      '${_qty}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Divider(),
              ...(((_item?['transactions'] ?? []) as List<dynamic>)
                  .asMap()
                  .map((key, value) {
                    return MapEntry(
                        key,
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Card(
                                child: InkWell(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Row(
                                              children: [
                                                ...[
                                                  Container(
                                                    child: Text(
                                                        '${value?['in_out_type'] ?? ''}'),
                                                  )
                                                ],
                                                ...(value?['in_out_type'] ==
                                                        'in'
                                                    ? [
                                                        Container(
                                                          child: Icon(
                                                              Icons.arrow_back),
                                                        )
                                                      ]
                                                    : []),
                                                ...(value?['in_out_type'] ==
                                                        'out'
                                                    ? [
                                                        Container(
                                                          child: Icon(Icons
                                                              .arrow_forward),
                                                        )
                                                      ]
                                                    : []),
                                              ],
                                            )),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  'Qty: ${value?['qty'] ?? ''}'),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: Text(
                                                  '${DateFormat.yMMMEd().add_jms().format(DateTime.parse(value?['created_at']).toLocal())}'),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: Text('Borrow: '),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: Text('Purchase Request: '),
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                  })
                  .values
                  .toList()
                  .reversed)
            ],
          ),
        ),
      ),
    );
  }
}
