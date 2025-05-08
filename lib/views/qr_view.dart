import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRView extends StatelessWidget {
  final Function(Barcode) onDetect;

  const QRView({super.key, required this.onDetect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SCAN QR CODE'),
      ),
      body: MobileScanner(
        onDetect: (barcodeCapture) {
          final barcode = barcodeCapture.barcodes.first;
          onDetect(barcode);
        },
      ),
    );
  }
}