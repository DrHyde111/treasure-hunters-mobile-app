import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  Map<String, String> credentials = {};
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
                    child: Column(
                      children: [
                        const Text(
                          "Please login.",
                          style: TextStyle(fontSize: 30),
                        ),
                        TextFormField(
                          onChanged: (value) => {
                            credentials['email'] = value,
                          },
                          decoration: const InputDecoration(
                              hintText: 'Enter your email'),
                        ),
                        TextFormField(
                          onChanged: (value) => {
                            credentials['password'] = value,
                          },
                          decoration: const InputDecoration(
                              hintText: 'Enter your password'),
                        ),
                        ElevatedButton(
                            onPressed: () => {print(credentials)},
                            child: const Text("Login"))
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
