import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_taller/viewmodels/login_view_model.dart';
import 'package:flutter_taller/views/add_car_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _attemptLogin(BuildContext context) async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final success = await loginViewModel.login({
      "username": _usernameController.text,
      "password": _passwordController.text,
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AddCarView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final isSuccess = loginViewModel.token != null;
    final errorMessage = loginViewModel.error;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                loginViewModel.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => _attemptLogin(context),
                        child: const Text('Sign In'),
                      ),
                const SizedBox(height: 10),
                if (errorMessage != null)
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                if (isSuccess)
                  const Text(
                    "Login successful",
                    style: TextStyle(color: Colors.green),
                  ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You don't have an account?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () => _attemptLogin(context),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}