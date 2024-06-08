import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:schoolinventory/PurchaseRequestDetail.dart';
import 'package:schoolinventory/borrowdetail.dart';
import 'package:schoolinventory/genericscaffold.dart';
import 'package:schoolinventory/helpers.dart';

class PurchaseRequestListPage extends StatefulWidget {
  const PurchaseRequestListPage({
    super.key,
    this.onSave,
  });

  final Function? onSave;
  // final dynamic? id;

  @override
  State<PurchaseRequestListPage> createState() => _PurchaseRequestListPageState();
}

class _PurchaseRequestListPageState extends State<PurchaseRequestListPage> {
  var _nameController = TextEditingController();

  List<dynamic> _purchaseRequests = [];

  @override
  void initState() {
    fetchPurchaseRequestsData();
    super.initState();
  }

  Future fetchPurchaseRequestsData() async {
    // if (widget.id != null) {
    final d = await fetchPurchaseRequests();

    print(d);
    setState(() {
      _purchaseRequests = d;
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
        child: Container(
          child: Column(
            children: [
              Container(
                child: Text(
                  'Purchase Request List',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // Text(jsonEncode(_borrows)),
              Divider(),
              ...(((_purchaseRequests ?? []) as List<dynamic>)
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
                                            builder: (_) => PurchaseRequestDetailPage(
                                                  id: value?['id'],
                                                  onSave: () async {
                                                    fetchPurchaseRequestsData();
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
                                              child: Text('Requested by: '),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: Text('Approved by: '),
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
