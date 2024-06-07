import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:schoolinventory/helpers.dart';
import 'package:collection/collection.dart';

class BorrowDetailPage extends StatefulWidget {
  const BorrowDetailPage({super.key, this.onSave, this.id});

  final Function? onSave;
  final dynamic? id;

  @override
  State<BorrowDetailPage> createState() => _BorrowDetailPageState();
}

class _BorrowDetailPageState extends State<BorrowDetailPage> {
  var _nameController = TextEditingController();

  dynamic _borrow = {};
  dynamic _item = {};

  @override
  void initState() {
    fetchBorrowData();
    super.initState();
  }

  // dynamic _borrow = null;

  Future fetchBorrowData() async {
    if (widget.id != null) {
      final d = await fetchBorrow(widget.id);

      print('ok borrow');
      print(d);

      setState(() {
        _borrow = d;
        // _nameController.text = d?['name'];
      });

      // Also fetch item
      if (d?['item_id'] != null) {
        final item = await fetchItem(d?['item_id']);

        setState(() {
          _item = item;
        });

        print('ok item');
        print(item);
      }
    }
  }

  Future handleSave(int status) async {
    try {
      final res = await http.post(
        Uri.parse(
            '${dotenv.get('BASE_URL')}/api/borrows/${widget.id}/approve/${status}'),
        headers: {'content-type': 'application/json'},
      );

      print('ok approve');
      print(res.body);
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
        title: Text('Borrow Detail ${widget.id}'),
        actions: [
          // Container(
          //   child: ElevatedButton(
          //     child: Text('Save'),
          //     onPressed: () async {
          //       handleSave();
          //     },
          //   ),
          // )
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
              Container(
                child: Text('Requested: ${_borrow?['qty']}'),
              ),
              ...(_borrow?['approval_status'] == null || _borrow?['approval_status'] == 0
                  ? [
                      Container(
                        child: Row(
                          children: [
                            ElevatedButton(
                              child: Text('Approve'),
                              onPressed: () async {
                                handleSave(1);
                              },
                            ),
                            ElevatedButton(
                              child: Text('Reject'),
                              onPressed: () async {
                                handleSave(2);
                              },
                            )
                          ],
                        ),
                      )
                    ]
                  : []),
              ...(_borrow?['approval_status'] == 1
                  ? [
                      Container(
                        child: Row(
                          children: [
                            ElevatedButton(
                              child: Text('Return'),
                              onPressed: () async {
                                handleSave(3);
                              },
                            )
                          ],
                        ),
                      )
                    ]
                  : []),
            ],
          ),
        ),
      ),
    );
  }
}
