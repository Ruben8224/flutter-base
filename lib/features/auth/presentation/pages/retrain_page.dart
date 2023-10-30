import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RetrainPage extends StatefulWidget {
  static const String id = "Retrain_Page";

  const RetrainPage({Key? key}) : super(key: key);

  @override
  _RetrainPageState createState() => _RetrainPageState();
}

class _RetrainPageState extends State<RetrainPage> {
  Future<void> _retrainModel() async {
    final Map<String, dynamic> requestData = {
      "event_type": "ml_ci_cd",
      "client_payload": {
        "dataseturl":
            "https://firebasestorage.googleapis.com/v0/b/taxi-prediction-83806.appspot.com/o/train.csv?alt=media&token=4dabe785-153e-41de-bc46-ca437b316f34",
        "sha": "taxi",
      }
    };

    final String githubToken = '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'; // Reemplaza con tu token de GitHub
    final String url = 'https://api.github.com/repos/Ruben8224/Taxi-trip--fare-prediction/dispatches';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $githubToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 204) {
      // Maneja la respuesta exitosa aquí
      print('Solicitud de reentrenamiento enviada con éxito.');
    } else {
      // Maneja errores o respuestas no exitosas aquí
      print('Error al enviar la solicitud de reentrenamiento: ${response.reasonPhrase}');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(232, 12, 24, 56),
    appBar: AppBar(
      title: Text(
        "Taxi trip fare prediction",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 58, 29, 108),
    ),
    body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Text(
                "Esta es la pantalla de reentrenamiento del modelo.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              ElevatedButton(
                onPressed: _retrainModel,
                child: Text(
                  'Reentrenar modelo',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 58, 29, 108),
                  padding: EdgeInsets.symmetric(horizontal: 125, vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ), // Cierra el ElevatedButton aquí
            ],
          ),
        ),
      ),
    ),
  );
}
}