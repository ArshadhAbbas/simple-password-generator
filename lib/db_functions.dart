import 'package:flutter/material.dart';
import 'package:password_generator/data_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<PasswordModel>> passwordsList = ValueNotifier([]);
late Database _db;

Future<void> initializeDatabase() async {
  _db = await openDatabase(
    'passwords.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE passwordDB (id INTEGER PRIMARY KEY, service TEXT, password TEXT)');
    },
  );
}

Future<void> addPassword(PasswordModel value) async {
  await _ensureInitialized();
  await _db.rawInsert('INSERT INTO passwordDB(service, password) VALUES(?, ?)',
      [value.service, value.password]);
  await getPasswords();
}

Future<void> getPasswords() async {
  await _ensureInitialized();
  final values = await _db.rawQuery('SELECT * FROM passwordDB');
  passwordsList.value.clear();
  values.forEach((map) {
    final password = PasswordModel.fromMap(map);
    passwordsList.value.add(password);
    passwordsList.notifyListeners();
  });
}

Future<void> deletePassword(int id) async {
  await _db.rawDelete('DELETE FROM passwordDB WHERE id = ?', [id]);
  passwordsList.notifyListeners();
  getPasswords();
}

Future<void> _ensureInitialized() async {
  if (_db == null) {
    await initializeDatabase();
  }
}
