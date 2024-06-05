import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolinventory/appstate.dart';

class GenericScaffold extends StatefulWidget {
  const GenericScaffold({super.key, this.body, this.fab});

  final Widget? body ;
  final Widget? fab ;

  @override
  State<GenericScaffold> createState() => _GenericScaffoldState();
}

class _GenericScaffoldState extends State<GenericScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Consumer<AppState>(
          builder: (ctx, state, child) {
            return Text('School Inventory ${state?.currentPage}');
          },
        ),
      ),
      drawer: Drawer(
        child: Consumer<AppState>(
          builder: (ctx, state, child) {
            return ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    try {
                      state.setCurrentPage(0);
                    } catch (e) {
                      print(e);
                    }

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Users'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    try {
                      state.setCurrentPage(1);
                    } catch (e) {
                      print(e);
                    }

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Items'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    state.setCurrentPage(2);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Borrow List'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    state.setCurrentPage(3);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Purchase Request List'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    state.setCurrentPage(4);

                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: widget.body,
      floatingActionButton: widget
          .fab, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
