import 'package:flutter/material.dart';
import 'package:flutter_taller/services/car_service.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  List<dynamic> _cars = [];
  bool _isLoading = true;
  final CarService _carsService = CarService();

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars() async {
    List<dynamic>? cars = await _carsService.getCars();
    setState(() {
      _cars = cars;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car List')),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _cars.length,
                itemBuilder: (context, index) {
                  var car = _cars[index];
                  return Card(
                    child: InkWell(
                      child: ListTile(
                        leading:
                            car['imagen'] != null
                                ? Image.network(
                                  car["imagen"]!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.error,
                                    );
                                  },
                                )
                                : Icon(Icons.car_repair),
                        title: Text('Placa: ${car['placa']}'),
                        subtitle: Text('Conductor: ${car['conductor']}'),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
