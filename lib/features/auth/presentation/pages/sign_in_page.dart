import 'package:flutter/material.dart';
import 'package:ui_one/features/auth/presentation/pages/admin_page.dart';
import 'package:ui_one/features/auth/presentation/pages/main_home.dart';
import 'package:ui_one/features/auth/presentation/pages/sign_up_page.dart';
import 'package:ui_one/features/auth/presentation/pages/home.dart';
import 'package:ui_one/features/auth/presentation/validator/auth_validator.dart';
import '../../../../service/auth_service.dart';

class SignInPage extends StatefulWidget {
  static const String id = "sign_in_page";

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _signInGlobalKey = GlobalKey<FormState>();
  TextEditingController usernameController =
      TextEditingController(); // Cambio en el controlador
  TextEditingController passwordController = TextEditingController();
  bool passwordSee = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 8, 39), // Cambia el color de fondo aquí
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  "Iniciar sesión",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Color del texto
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
                child: Text(
                  "¡Bienvenido de nuevo! ¿Qué te trae por aquí?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey, // Color del texto
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Form(
                key: _signInGlobalKey,
                child: Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            Colors.grey,
                            Colors.white
                          ], // Cambia los colores según tus necesidades
                        ).createShader(bounds);
                      },
                      child: TextFormField(
                        controller:
                            usernameController, // Cambio en el controlador
                        validator: AuthValidator
                            .isNameValid, // Cambio en la función de validación
                        decoration: InputDecoration(
                          hintText: "Nombre de usuario", // Cambio en la etiqueta
                          hintStyle: TextStyle(color: Colors.white), // Color del texto de sugerencia
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white), // Color de la línea
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white), // Color de la línea cuando está enfocado
                          ),
                        ),
                        style: TextStyle(color: Colors.white), // Color del texto del campo
                      ),
                    ),
                    SizedBox(
                      height: 40,
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
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: passwordSee,
                        validator: AuthValidator.isPasswordValid,
                        decoration: InputDecoration(
                          hintText: "Contraseña",
                          hintStyle: TextStyle(color: Colors.white), // Color del texto de sugerencia
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white), // Color de la línea
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white), // Color de la línea cuando está enfocado
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              passwordSee = !passwordSee;
                              setState(() {});
                            },
                            child: Icon(
                              passwordSee
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white, // Color del icono de visibilidad
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.white), // Color del texto del campo
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: signIn,
                child: Text(
                  "Siguiente",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Cambia el color del botón
                  padding: EdgeInsets.symmetric(horizontal: 125, vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "¿No tienes una cuenta?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Color del texto
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navegar a la página de registro cuando se presione
                  Navigator.pushNamed(context, SignUpPage.id);
                },
                child: Text(
                  "Registrarse",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 17, 54, 112), // Cambia el color del texto
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (_signInGlobalKey.currentState!.validate()) {
      final authService = AuthService();

      final token = await authService.login(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      if (token != null) {
        // La autenticación fue exitosa, aquí puedes navegar a la página principal
        Navigator.pushNamed(context, HomeScreen.id);
      } else {
        // La autenticación falló, muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Inicio de sesión fallido"),
            // Configura el estilo de tu SnackBar
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose(); // Cambio en el nombre del controlador
    passwordController.dispose();
    super.dispose();
  }
}
