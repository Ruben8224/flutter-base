// lib/presentation/pages/landing_page.dart

import 'package:flutter/material.dart';

import 'sign_in_page.dart';
import 'sign_up_page.dart';

class LandingPage extends StatelessWidget {
  static const String id = "landing_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 203, 41, 41), // Cambia el color de fondo aquí
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final textScaleFactor = (constraints.maxWidth < 600)
                ? 0.8
                : 1.0; // Ajusta según tus necesidades

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo de tu app
                Image.asset(
                  'assets/images/Logo.png', // Reemplaza con la ruta de tu logo
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 70),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Colors.grey,
                        Colors.white
                      ], // Cambia los colores según tus necesidades
                    ).createShader(bounds);
                  },
                  child: Text(
                    "Bienvenido a nuestra Aplicación",
                    style: TextStyle(
                      fontSize: 30 * textScaleFactor,
                      color: Colors
                          .white, // Color del texto, puedes cambiarlo si lo deseas
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Botón para crear una cuenta
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpPage.id);
                  },
                  style: ElevatedButton.styleFrom(
                    primary:
                        Color.fromARGB(255, 117, 116, 116), // Color del botón
                  ),
                  child: Text(
                    'Crear una cuenta',
                    style: TextStyle(
                      fontSize: 26 * textScaleFactor,
                    ),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Colors.grey,
                        Colors.white
                      ], // Cambia los colores según tus necesidades
                    ).createShader(bounds);
                  },
                  child: SizedBox(height: 20),
                ),
                // Texto para iniciar sesión
                // Texto para iniciar sesión
GestureDetector(
  onTap: () {
    Navigator.pushNamed(context, SignInPage.id);
  },
  child: ShaderMask(
    shaderCallback: (Rect bounds) {
      return LinearGradient(
        colors: [
          Colors.grey,
          Colors.white,
        ], // Cambia los colores según tus necesidades
      ).createShader(bounds);
    },
    child: Text(
      '¿Ya tienes una cuenta? Iniciar sesión',
      style: TextStyle(
        color: Colors.white, // Color del texto
        fontSize: 22 * textScaleFactor,
      ),
    ),
  ),
),

              ],
            );
          },
        ),
      ),
    );
  }
}
