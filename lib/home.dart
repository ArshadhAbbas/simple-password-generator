import 'package:flutter/material.dart';
import 'package:password_generator/data_model.dart';
import 'package:password_generator/db_functions.dart';
import 'package:password_generator/saved_screen.dart';
import 'package:password_generator/specs.dart';
import 'package:password_generator/textfield.dart';

enum MenuItem { saved, about }

class HomePage extends StatelessWidget {
  HomePage({Key? key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Password Generator"),
        actions: [
          PopupMenuButton<MenuItem>(
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: MenuItem.saved, child: Text("Saved passwords")),
              const PopupMenuItem(value: MenuItem.about, child: Text("About")),
            ],
            onSelected: (value) {
              if (value == MenuItem.saved) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SavedPasswords(),
                ));
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const PasswordSpecifications(),
            CustomTextField(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSaveDialog(context);
        },
        child: const Text("Save"),
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    TextEditingController serviceController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Colors.grey,
          title: const Text("Save Passwords"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Cannot be Empty";
                    }
                    return null;
                  },
                  controller: serviceController,
                  decoration:
                      const InputDecoration(labelText: "Website or App"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Cannot be Empty";
                    }
                    return null;
                  },
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String service = serviceController.text;
                  String password = passwordController.text;
                  final serviceAndPassword =
                      PasswordModel(service: service, password: password);
                  addPassword(serviceAndPassword);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Saved successfully")));
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
