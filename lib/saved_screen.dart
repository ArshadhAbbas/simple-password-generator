import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/data_model.dart';
import 'package:password_generator/db_functions.dart';

class SavedPasswords extends StatelessWidget {
  const SavedPasswords({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Saved Passwords"),
      ),
      body: ValueListenableBuilder(
        valueListenable: passwordsList,
        builder: (context, passwords, child) {
          if (passwords.isEmpty) {
            return const Center(
              child: Text(
                "No passwords saved yet.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              final data = passwords[index];
              return _buildPasswordListTile(context, data);
            },
            separatorBuilder: ((context, index) {
              return const Divider();
            }),
            itemCount: passwords.length,
          );
        },
      ),
    );
  }

  // Function to copy text to the clipboard
  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password copied to clipboard"),
      ),
    );
  }

  Widget _buildPasswordListTile(BuildContext context, PasswordModel data) {
    return ListTile(
      title: Text(data.service),
      subtitle: Text(data.password),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text("Copy"),
            onTap: () {
              _copyToClipboard(context, data.password);
            },
          ),
          PopupMenuItem(
            child: const Text("Delete"),
            onTap: () async {
              await deletePassword(data.id!);
            },
          ),
        ],
      ),
    );
  }
}
