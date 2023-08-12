import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({super.key});
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          final data = ClipboardData(text: textController.text);
                          Clipboard.setData(data);
                        },
                        icon: const Icon(Icons.copy_rounded))),
                readOnly: true,
                enableInteractiveSelection: false,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                final passwordProvider = context.read<PasswordProvider>();
                if (!passwordProvider.isLowerCase &&
                    !passwordProvider.isUpperCase &&
                    !passwordProvider.isNum &&
                    !passwordProvider.isSpecial) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Check at least one box. Everything cannot be empty")));
                } else {
                  final password = generatePassword(context);
                  textController.text = password;
                }
              },
              child: const Text("Generate"))
        ],
      ),
    );
  }

  String generatePassword(BuildContext ctx) {
    final specsProvider = ctx.read<PasswordProvider>();
    final length = ctx.read<PasswordProvider>().numValue;
    const upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const numbers = '1234567890';
    const special = '!@#%^&*()_+|}{[]}>.<,?/';

    String chars = '';
    if (specsProvider.isLowerCase) chars += lowercase;
    if (specsProvider.isUpperCase) chars += upperCase;
    if (specsProvider.isNum) chars += numbers;
    if (specsProvider.isSpecial) chars += special;

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join();
  }
}
