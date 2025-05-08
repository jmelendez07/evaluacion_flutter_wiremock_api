import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_taller/models/car_model.dart';
import 'package:flutter_taller/viewmodels/car_view_model.dart';
import 'package:flutter_taller/views/cars_view.dart';

class ShowCarView extends StatefulWidget {
  final String id;

  const ShowCarView({super.key, required this.id});

  @override
  State<ShowCarView> createState() => _ShowCarViewState();
}

class _ShowCarViewState extends State<ShowCarView> {
  CarModel? _car;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCar();
  }

  Future<void> _loadCar() async {
    try {
      final carViewModel = Provider.of<CarViewModel>(context, listen: false);
      final fetchedCar = await carViewModel.getCarByIdFromApi(widget.id);

      if (!mounted) return;
      
      setState(() {
        _car = fetchedCar;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(child: Text('Error al cargar el auto: $_error')),
      );
    }

    if (_car == null) {
      return const Scaffold(
        body: Center(child: Text('No se encontraron datos')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Auto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCarDetails(_car!),
            const Spacer(),
            _buildActionButtons(context, _car!),
          ],
        ),
      ),
    );
  }

  Widget _buildCarDetails(CarModel car) {
    return Column(
      children: [
        Image.network(
          car.imagen,
          height: 150,
          width: 150,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported, size: 150),
        ),
        const SizedBox(height: 20),
        Text('Conductor: ${car.conductor}', style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        Text('Placa: ${car.placa}', style: const TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, CarModel car) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            final carViewModel = Provider.of<CarViewModel>(context, listen: false);
            await carViewModel.saveCar(car);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CarsView()),
            );
          },
          child: const Text('Guardar en mis autos'),
        ),
      ],
    );
  }
}
