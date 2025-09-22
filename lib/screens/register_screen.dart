import 'package:flutter/material.dart';
import 'package:shopping_cart/models/user_models.dart';
import 'package:shopping_cart/screens/login_screen.dart';
import 'package:shopping_cart/services/auth_sqlite_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthSqliteService _authService = AuthSqliteService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authService.OpenDatabaseFunc();
  }

  Future<void> HandleRegister() async {
    final userModel = UserModel(
      email: _emailController.text,
      password: _passwordController.text,
    );
    await _authService.insertUser(userModel);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kayıt başarılı, login ekranına yönlendiriliyorsunuz!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 75),
                  width: 250,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.only(left: 75),
                  width: 250,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 75),
                  child: ElevatedButton(
                    onPressed: () {
                      HandleRegister();
                    },
                    child: Text('Kayıt Ol'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
