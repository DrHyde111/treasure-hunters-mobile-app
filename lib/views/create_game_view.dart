import 'package:flutter/material.dart';

class CreateGameView extends StatefulWidget {
  const CreateGameView({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<CreateGameView> createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> {
  final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();
  final creator = TextEditingController();

  final points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New game'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty!';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Enter title'),
              ),
              TextFormField(
                controller: description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty!';
                  }
                  return null;
                },
                decoration:
                    const InputDecoration(hintText: 'Enter description'),
              ),
              TextFormField(
                controller: creator,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty!';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Enter creator'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
