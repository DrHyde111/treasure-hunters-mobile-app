import 'package:flutter/material.dart';
import 'package:treasure_hunters/views/menu_view.dart';

import '../services/api_services.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Login",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Please login.",
                          style: TextStyle(fontSize: 30),
                        ),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be empty!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Enter your email'),
                        ),
                        TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be empty!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Enter your password'),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                errorMessage = '';
                              });
                              var response;
                              if (_formKey.currentState!.validate()) {
                                try {
                                  response =
                                      await login(email.text, password.text);
                                  const storage = FlutterSecureStorage();
                                  await storage.write(
                                      key: 'token', value: response['token']);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MenuView(token: response['token'])),
                                    (Route<dynamic> route) => false,
                                  );
                                } catch (error) {
                                  setState(() {
                                    errorMessage = error.toString();
                                  });
                                }
                              }
                            },
                            child: const Text("Login")),
                        errorMessage != ''
                            ? Card(
                                color: Colors.redAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(errorMessage.toString()),
                                ),
                              )
                            : const Text('')
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
