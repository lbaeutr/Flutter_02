import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // Función para manejar el inicio de sesión
    void login() {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        // Navegar a la pantalla principal si las credenciales son correctas
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Mostrar un mensaje de error si los campos están vacíos
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Por favor, ingresa email y contraseña"),
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
                              // Campo de texto para el email
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                ),
                              ),
                              // Campo de texto para la contraseña
                              TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  labelText: "Contraseña",
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
                              // Botón para iniciar sesión
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: login,
                                child: const Text("Ingresar"),
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
