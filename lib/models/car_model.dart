class CarModel {
  final String id;
  final String conductor;
  final String placa;
  final String imagen;

  CarModel({
    required this.id,
    required this.conductor,
    required this.placa,
    required this.imagen,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      conductor: json['conductor'],
      placa: json['placa'],
      imagen: json['imagen'],
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id,
      'conductor': conductor,
      'placa': placa,
      'imagen': imagen,
    };
  }
}