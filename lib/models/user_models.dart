class UserModel {
  final String email;
  final String password;

  const UserModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
