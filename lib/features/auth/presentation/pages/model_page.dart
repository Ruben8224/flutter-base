import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelPage extends StatefulWidget {
  static const String id = "Model_Page";
  const ModelPage({super.key});

  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  final _formKey = GlobalKey<FormState>();
  String _respuesta = '';
  int? age, drivingLicense, regionCode, previouslyInsured;
  double? policySalesChannel, vintage;

  Future<void> _consultarModelo() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.parse(
          'https://predict-taxi-centenito-service-ruben8224.cloud.okteto.net/predict');
      final response = await http.post(url,
          body: json.encode({
    "distance_traveled": 3.43,
    "num_of_passengers":  1.0,
    "miscellaneous_fees":  13.200000000000017,
    "trip_duration": 1187
}),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        print(jsonResponse);
        double? price = jsonResponse['fare'];
        setState(() {
          _respuesta = ' ${price?.toStringAsFixed(2)}';
        });
      } else {
        setState(() {
          _respuesta =
              'Error al obtener respuesta, revisa que todos los campos sean válidos';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(232, 12, 24, 56), // Cambia el color de fondo aquí

      appBar: AppBar(
        title: Text(
          "Taxi trip fare prediction",
          style: TextStyle(
            color: Colors.white, // Texto del título en blanco
            // Aquí puedes ajustar otros estilos de texto, como tamaño de fuente, etc.
          ),
        ),
        backgroundColor: Color.fromARGB(255, 58, 29, 108),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // TextFormFields y DropdownButtonFormField para los nuevos campos
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'distancia viajada',
                      labelStyle: TextStyle(
                        color: Colors.grey, // Color del texto del label (gris)
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Color del borde cuando no está enfocado
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255)), // Color del borde cuando está enfocado
                      ),
                      hintStyle: TextStyle(color: Colors.grey), // Color del texto de sugerencia (gris)
                    ),
                    style: TextStyle(
                      color: Colors.white, // Color del texto de entrada (blanco)
                      // Aquí puedes ajustar otros estilos de texto, como tamaño de fuente, etc.
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => age = int.tryParse(value ?? ''),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '¿Cuantos Pasajeros?',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => drivingLicense = int.tryParse(value ?? ''),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Millas Recorridas',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => regionCode = int.tryParse(value ?? ''),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Duración',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => previouslyInsured = int.tryParse(value ?? ''),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _consultarModelo,
                  child: Text(
                    'Consultar Modelo',
                    style: TextStyle(
                      color: Colors.white, // Texto del botón en blanco
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary:  Color.fromARGB(255, 16, 69, 68),
                    padding: EdgeInsets.symmetric(horizontal: 125, vertical: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 3, 105, 44),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Predicción: \$$_respuesta',
                    style: TextStyle(
                      color: Colors.white, // Texto en blanco para mejor contraste
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
