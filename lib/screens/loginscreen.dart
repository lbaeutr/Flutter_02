import 'package:flutter/material.dart';
import 'package:flutter_listatareas_api/service/api_service.dart';
import 'package:flutter_listatareas_api/widgets/common_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final ApiService apiService = ApiService(
      baseUrl: 'https://api-rest-segura-2.onrender.com',
    );

    // Función para manejar el inicio de sesión
    void login() async {
      if (usernameController.text.isNotEmpty &&          passwordController.text.isNotEmpty) {
        try {
          await apiService.login(usernameController.text, passwordController.text);
          // Navegar a la pantalla principal si las credenciales son correctas
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Inicio de sesión exitoso")),
          );
          Navigator.pushReplacementNamed(context, '/home');
        } catch (e) {
          // Mostrar un mensaje de error si la petición falla
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al iniciar sesión: $e")),
          );
        }
      } else {
        // Mostrar un mensaje de error si los campos están vacíos
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Por favor, ingresa nick y contraseña"),
          ),
        );
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Verificar si el teclado está abierto
        final bool isKeyboardOpen =
            MediaQuery.of(context).viewInsets.bottom > 0;

        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Mostrar el logo solo si el teclado está cerrado
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isKeyboardOpen ? 0.0 : 1.0,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Image.asset(
                            'lib/assets/logo.png',
                            height: 100,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Iniciar Sesión",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: usernameController,
                                labelText: "Username",
                              ),
                              CustomTextField(
                                controller: passwordController,
                                labelText: "Contraseña",
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
                              CustomButton(
                                text: "Ingresar",
                                onPressed: login,
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              // Botón para navegar a la pantalla de registro
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed:
                                    () => Navigator.pushNamed(
                                      context,
                                      '/register',
                                    ),
                                child: const Text("Crear cuenta"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Mostrar el texto en la parte inferior solo si el teclado está cerrado
              if (!isKeyboardOpen)
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "⌨\uFE0F con ❤\uFE0F por Luis Baena",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
