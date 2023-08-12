class PasswordModel {
  int? id;
  final String service;
  final String password;
  PasswordModel({required this.service, required this.password, this.id});

  static PasswordModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final service = map['service'] as String;
    final password = map['password'] as String;

    return PasswordModel(id: id, service: service, password: password);
  }
}
