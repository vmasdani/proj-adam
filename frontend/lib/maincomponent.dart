import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolinventory/appstate.dart';
import 'package:schoolinventory/borrowitem.dart';
import 'package:schoolinventory/borrowlist.dart';
import 'package:schoolinventory/genericscaffold.dart';
import 'package:schoolinventory/inventory.dart';
import 'package:schoolinventory/items.dart';
import 'package:schoolinventory/purchaserequestitem.dart';
import 'package:schoolinventory/purchaserequestlist.dart';

class MainComponent extends StatefulWidget {
  const MainComponent({super.key});

  @override
  State<MainComponent> createState() => _MainComponentState();
}

class _MainComponentState extends State<MainComponent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, value, child) {
        switch (value.currentPage) {
          case 0:
            return GenericScaffold(
              body: Container(
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                alignment: Alignment.topLeft,
                child: Text('Home'),
              ),
            );

          case 1:
            return GenericScaffold(
              body: Container(
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                alignment: Alignment.topLeft,
                child: Text('Users'),
              ),
            );

          case 2:
            return ItemsPage();

          case 3:
            return BorrowItemPage();

          case 4:
            return PurchaseRequestItemPage();

          case 5:
            return InventoryPage();

          case 6:
            return BorrowListPage();
            
          case 7:
            return PurchaseRequestListPage();

          default:
            return GenericScaffold(
              body: Container(
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                alignment: Alignment.topLeft,
                child: Text('page invalid'),
              ),
            );
        }
      },
    );
  }
}
