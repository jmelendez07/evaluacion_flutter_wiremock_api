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

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars() async {
    List<dynamic>? cars = await CarService.fetchCars();
    setState(() {
      _cars = cars ?? [];
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
                                  'https://api.allorigins.win/raw?url=' + car["imagen"],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                        ),
                                      );
                                    }
                                  },
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
