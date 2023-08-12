import 'package:flutter/material.dart';
import 'package:password_generator/provider.dart';
import 'package:provider/provider.dart';

class PasswordSpecifications extends StatefulWidget {
  const PasswordSpecifications({super.key});

  @override
  State<PasswordSpecifications> createState() => _PasswordSpecificationsState();
}

class _PasswordSpecificationsState extends State<PasswordSpecifications> {
  // bool isNum = false;
  // bool isUpperCase = false;
  // bool isSpecial = false;
  // int _value = 8;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CheckboxListTile(
          value: context.watch<PasswordProvider>().isLowerCase,
          onChanged: (value) => context.read<PasswordProvider>().switchLoweCase(value!),
          title: const Text("Lower Case Letters"),
        ),
        const SizedBox(
          height: 12,
        ),
        CheckboxListTile(
          value: context.watch<PasswordProvider>().isUpperCase,
          onChanged: (value) => context.read<PasswordProvider>().switchUppercase(value!),
          title: const Text("Upper Case Letters"),
        ),
        const SizedBox(
          height: 12,
        ),
        CheckboxListTile(
          value: context.watch<PasswordProvider>().isNum,
          onChanged: (value) => context.read<PasswordProvider>().switchNumber(value!),
          title: const Text("Numbers"),
        ),
        const SizedBox(
          height: 12,
        ),
        CheckboxListTile(
          value: context.watch<PasswordProvider>().isSpecial,
          onChanged: (value) =>context.read<PasswordProvider>().switchSpecials(value!),
          title: const Text("Special Characters"),
        ),
        const SizedBox(
          height: 12,
        ),
        const Text("Number of Characters"),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: context.watch<PasswordProvider>().numValue.toDouble(),
                onChanged: (value)=>context.read<PasswordProvider>().switchLength(value),
                max: 20,
                min: 4,
                divisions: 16,
                label: context.watch<PasswordProvider>().numValue.toString(),
              ),
            ),
            Text(context.watch<PasswordProvider>().numValue.toString())
          ],
        )
      ],
    );
  }
}
