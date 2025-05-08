import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_taller/viewmodels/car_view_model.dart';

class CarsView extends StatelessWidget {
  const CarsView({super.key});

  @override
  Widget build(BuildContext context) {
    final carViewModel = Provider.of<CarViewModel>(context);
    final cars = carViewModel.cars;
    final isLoading = carViewModel.isLoading;

    if (cars.isEmpty && !isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        carViewModel.loadCarsFromStorage();
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Car List')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return Card(
                  child: ListTile(
                    leading: car.imagen.isNotEmpty
                        ? Image.network(
                            car.imagen,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                          )
                        : const Icon(Icons.car_repair),
                    title: Text('Placa: ${car.placa}'),
                    subtitle: Text('Conductor: ${car.conductor}'),
                  ),
                );
              },
            ),
    );
  }
}