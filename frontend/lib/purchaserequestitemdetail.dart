import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:schoolinventory/appstate.dart';
import 'package:schoolinventory/helpers.dart';
import 'package:transparent_image/transparent_image.dart';

class PurchaseRequestItemDetailPage extends StatefulWidget {
  const PurchaseRequestItemDetailPage({super.key, this.onSave, this.id});

  final Function? onSave;
  final dynamic? id;

  @override
  State<PurchaseRequestItemDetailPage> createState() =>
      _PurchaseRequestItemDetailPageState();
}

class _PurchaseRequestItemDetailPageState
    extends State<PurchaseRequestItemDetailPage> {
  var _qtyController = TextEditingController(text: '1');

  dynamic _item = {};
  double _qty = 1;

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
        // _nameController.text = d?['name'];
      });
    }
  }

  Future handleSave() async {
    try {
      final ctx = Provider.of<AppState>(context, listen: false);

      await http.post(
          Uri.parse('${dotenv.get('BASE_URL')}/api/purchaserequests'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode({
            'item_id': _item?['id'],
            'qty': _qty,
            'approval_status': 0,
            'user_id': ctx?.user?['id']
          }));

      ctx.setCurrentPage(7);
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
        title: Text('Purchase Request ${widget.id}'),
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
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            Row(
              children: [
                Text('Item: '),
                Text(
                  _item?['name'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Text('Description: '),
                Text(
                  _item?['description'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Text('In stock: '),
                Text(
                  '${calculateStock(_item?['transactions'] ?? [])}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  child: TextField(
                    onChanged: (v) {
                      final d = double.tryParse(v);

                      if (d != null) {
                        _qty = d;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Qty'),
                  ),
                )),
                Container(
                  child: ElevatedButton(
                    child: Text('Add Purchase Request'),
                    onPressed: () {
                      handleSave();
                    },
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              // child: FractionallySizedBox(
              //   heightFactor: 0.4,
              child: FadeInImage(
                image: NetworkImage(
                    "${dotenv.get("BASE_URL")}/api/items/${widget.id}/photo?ts=${DateTime.now().millisecondsSinceEpoch}"),
                placeholder: MemoryImage(kTransparentImage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
