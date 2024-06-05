import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolinventory/appstate.dart';
import 'package:schoolinventory/genericscaffold.dart';
import 'package:schoolinventory/itemadd.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      fab: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ItemAddPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Text('Items'),
            )
          ],
        ),
      ),
    );
  }
}
