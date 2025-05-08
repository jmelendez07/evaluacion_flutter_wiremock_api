import 'package:flutter/material.dart';
import 'package:flutter_taller/views/cars_view.dart';
import 'package:flutter_taller/views/qr_view.dart';
import 'package:flutter_taller/views/show_car_view.dart';

class AddCarView extends StatelessWidget {
  const AddCarView({super.key});

  void _scanQR(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QRView(
          onDetect: (barcode) {
            if (barcode.rawValue != null) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ShowCarView(id: barcode.rawValue!),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _goToAllCars(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CarsView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get a new car')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome, select one option!'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _scanQR(context),
              child: const Text('Scan QR code'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _goToAllCars(context),
              child: const Text('Show all cars'),
            ),
          ],
        ),
      ),
    );
  }
}
