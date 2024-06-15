import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolinventory/appstate.dart';
import 'package:schoolinventory/helpers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(hintText: 'Username...'),
                  ),
                ),
              ),
              Container(
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: 'Password...'),
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text(
                    'Login',
                  ),
                  onPressed: () async {
                    final ctx = Provider.of<AppState>(context, listen: false);

                    if (_usernameController.text != null &&
                        _usernameController.text != "") {
                      try {
                        final d =
                            await login({'username': _usernameController.text});

      
                        if (d != null) {
                          ctx.setUser(d);
                        }
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Login error'),
                            );
                          },
                        );
                      } finally {
                        return;
                      }
                    }

                    ctx.setUser({
                      'username': 'Admin',
                      'role': 'Admin',
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
