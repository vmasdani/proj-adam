import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolinventory/appstate.dart';
import 'package:schoolinventory/genericscaffold.dart';
import 'package:schoolinventory/items.dart';

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
                alignment: Alignment.topLeft,
                child: Text('Home'),
              ),
            );

          case 1:
            return GenericScaffold(
              body: Container(
                alignment: Alignment.topLeft,
                child: Text('Users'),
              ),
            );
          case 2:
            return ItemsPage();

          case 3:
            return GenericScaffold(
              body: Container(
                alignment: Alignment.topLeft,
                child: Text('Borrow List'),
              ),
            );
          case 4:
            return GenericScaffold(
              body: Container(
                alignment: Alignment.topLeft,
                child: Text('Purchase Request'),
              ),
            );

          default:
            return GenericScaffold(
              body: Container(
                alignment: Alignment.topLeft,
                child: Text('page invalid'),
              ),
            );
        }
      },
    );
  }
}
