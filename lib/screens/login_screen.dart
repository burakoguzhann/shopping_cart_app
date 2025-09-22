import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_cart/models/user_models.dart';
import 'package:shopping_cart/screens/home_screen.dart';
import 'package:shopping_cart/screens/register_screen.dart';
import 'package:shopping_cart/services/auth_sqlite_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthSqliteService _authService = AuthSqliteService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authService.OpenDatabaseFunc();
  }

  Future<void> handleLogin() async {
    final userModel = UserModel(
      email: _emailController.text,
      password: _passwordController.text,
    );
    bool? success = await _authService.loginUser(userModel);
    if (success == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Giriş Başarılı')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Bir hata oluştu!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 255),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 35),
              width: 350,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(65),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 35),
              width: 350,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(65),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 35),
              child: ElevatedButton(
                onPressed: () {
                  handleLogin();
                },
                child: Text('Giriş Yap'),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 35),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text('Kayıt ol'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
