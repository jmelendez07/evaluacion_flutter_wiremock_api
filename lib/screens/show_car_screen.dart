import 'package:flutter/material.dart';
import 'package:flutter_taller/screens/cars_screen.dart';
import 'package:flutter_taller/services/car_service.dart';

class ShowCarScreen extends StatelessWidget {
  final String id;

  const ShowCarScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final carrosService = CarService();

    return FutureBuilder<Map<String, dynamic>?>(
      future: carrosService.getCarById(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error to load car: ${snapshot.error}')),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          final carro = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Car Details'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildCarDetails(carro),
                  const Spacer(),
                  _buildActionButtons(context, carrosService, carro),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('No se encontraron datos')),
          );
        }
      },
    );
  }

  Widget _buildCarDetails(Map<String, dynamic> carro) {
    return Column(
      children: [
        Image.network(
          carro['imagen'] ?? '',
          height: 150,
          width: 150,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image_not_supported, size: 150);
          },
        ),
        const SizedBox(height: 20),
        Text(
          'Conductor: ${carro['conductor'] ?? 'Desconocido'}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Text(
          'Placa: ${carro['placa'] ?? 'Desconocida'}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, CarService carrosService, Map<String, dynamic> carro) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => _saveCarAndNavigate(context, carrosService, carro),
          child: const Text('Save in my cars'),
        ),
      ],
    );
  }

  Future<void> _saveCarAndNavigate(BuildContext context, CarService carrosService, Map<String, dynamic> carro) async {
    Map<String, String> carroParaAlmacenar = {
      'id': carro['id'].toString(),
      'conductor': carro['conductor']?.toString() ?? '',
      'placa': carro['placa']?.toString() ?? '',
      'imagen': carro['imagen']?.toString() ?? '',
    };

    await carrosService.saveCar(carroParaAlmacenar);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CarsScreen(),
      ),
    );
  }
}