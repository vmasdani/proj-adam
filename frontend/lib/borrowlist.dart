import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schoolinventory/appstate.dart';
import 'package:schoolinventory/borrowdetail.dart';
import 'package:schoolinventory/genericscaffold.dart';
import 'package:schoolinventory/helpers.dart';

class BorrowListPage extends StatefulWidget {
  const BorrowListPage({
    super.key,
    this.onSave,
  });

  final Function? onSave;
  // final dynamic? id;

  @override
  State<BorrowListPage> createState() => _BorrowListPageState();
}

class _BorrowListPageState extends State<BorrowListPage> {
  var _nameController = TextEditingController();

  List<dynamic> _borrows = [];

  @override
  void initState() {
    fetchBorrowsData();
    super.initState();
  }

  Future fetchBorrowsData() async {
    // if (widget.id != null) {
    final d = await fetchBorrows();

    print(d);
    setState(() {
      _borrows = d;
      // _nameController.text = d?['name'];
    });
    // }
  }

  // Future handleSave() async {
  //   try {
  //     await http.post(Uri.parse('${dotenv.get('BASE_URL')}/api/items'),
  //         headers: {'content-type': 'application/json'},
  //         body: jsonEncode(_item));
  //   } catch (e) {
  //     print(e);
  //   }

  //   Navigator.pop(context);
  //   widget?.onSave?.call();
  // }

  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      // appBar: AppBar(
      //   title: Text('Borrow ${widget.id}'),
      //   actions: [
      //     Container(
      //       child: ElevatedButton(
      //         child: Text('Save'),
      //         onPressed: () async {
      //           // handleSave();
      //         },
      //       ),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Consumer<AppState>(
          builder: (context, value, child) => Container(
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Borrow List',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // Text(jsonEncode(_borrows)),
                Divider(),
                ...(((_borrows ?? []) as List<dynamic>)
                    .where((b) {
                      if (value?.user?['role'] == 'User') {
                        return value?.user?['id'] == b?['user']?['id'];
                      } else {
                        return true;
                      }
                    })
                    .toList()
                    .asMap()
                    .map((key, value) {
                      return MapEntry(
                          key,
                          Container(
                            child: Column(
                              children: [
                                Card(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => BorrowDetailPage(
                                                    id: value?['id'],
                                                    onSave: () async {
                                                      fetchBorrowsData();
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
                                                child: Text(
                                                    'Item: ${value?['item']?['name'] ?? ''}'),
                                              )),
                                              Container(
                                                child: checkApprovalStatus(
                                                    value?['approval_status'] ??
                                                        0),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                child: Text(
                                                    'Qty: ${value?['qty'] ?? 0}'),
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
                                                child: Text(
                                                    'Requested by: ${value?['user']?['username'] ?? ''}'),
                                              )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                child: Text(
                                                    'Approved by: ${value?['approval_user']?['username'] ?? ''}'),
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
      ),
    );
  }
}
