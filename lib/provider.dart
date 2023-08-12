import 'package:flutter/material.dart';

class PasswordProvider extends ChangeNotifier {
  bool isLowerCase = true;
  bool isUpperCase = false;
  bool isNum = false;
  bool isSpecial = false;
  int numValue = 8;

  void switchLoweCase(bool lowerCheck) {
    isLowerCase = lowerCheck;
    notifyListeners();
  }

  void switchUppercase(bool upperCheck) {
    isUpperCase = upperCheck;
    notifyListeners();
  }

  void switchNumber(bool numCheck) {
    isNum = numCheck;
    notifyListeners();
  }

  void switchSpecials(bool specialCheck) {
    isSpecial = specialCheck;
    notifyListeners();
  }

  void switchLength(double length) {
    numValue = length.toInt();
    notifyListeners();
  }
}
