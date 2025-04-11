import 'package:flutter/material.dart';
import 'package:flutter_taller/screens/add_car_screen.dart';
import 'package:flutter_taller/services/login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _statusMessage = "";

  void _validate() async {
    LoginService.fetch({
      "username": _usernameController.value.text,
      "password": _passwordController.value.text,
    }).then((value) {
      setState(() {
        _statusMessage = value ? "Login successful" : "incorrect username or password";
      });
      if (value) {
        _login();
      }
    });
  }

  void _login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCarScreen()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validate,
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 10),
              Text(
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  color: _statusMessage == "Login successful" ? Colors.green : Colors.red 
                ),
                _statusMessage,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold, 
                ),
                "you don't have an account?",
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: _validate,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}