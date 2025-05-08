import 'package:flutter/material.dart';
import 'package:flutter_taller/viewmodels/car_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_taller/views/login_view.dart';
import 'package:flutter_taller/viewmodels/login_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>( create: (_) => LoginViewModel() ),
        ChangeNotifierProvider<CarViewModel>( create: (_) => CarViewModel() ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}