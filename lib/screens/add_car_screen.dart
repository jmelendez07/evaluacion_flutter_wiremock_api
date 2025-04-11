import 'package:flutter/material.dart';
import 'package:flutter_taller/screens/cars_screen.dart';
import 'package:flutter_taller/screens/qr_screen.dart';
import 'package:flutter_taller/screens/show_car_screen.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();

}

class _AddCarScreenState extends State<AddCarScreen> {

  void _scanQR() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScreen(
          onDetect: (barcode) {
            if (barcode.rawValue != null) {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowCarScreen(id: barcode.rawValue!),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get a new car'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome, select one option!'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _scanQR,
              child: const Text('Scan QR code'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarsScreen(),
                  ),
                );
              },
              child: const Text('Show all cars'),
            ),
          ],
        ),
      ),
    );
  }
}