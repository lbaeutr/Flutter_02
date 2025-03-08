import 'package:flutter/material.dart';
import 'package:flutter_listatareas_api/service/api_service.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController passwordRepeatController = TextEditingController();
   
    final ApiService apiService = ApiService(baseUrl: 'https://api-rest-segura-2.onrender.com');

    // Función para manejar el registro
  void register() async {
  if (usernameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      passwordRepeatController.text.isNotEmpty 
     ) {
    try {
      await apiService.register(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordRepeat: passwordRepeatController.text,
      );
      // Mostrar mensaje de éxito y navegar a la pantalla de inicio de sesión
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cuenta creada con éxito")),
      );
      Navigator.pushReplacementNamed(context, '/'); // Asegúrate de que '/login' sea la ruta correcta
    } catch (e) {
      // Mostrar un mensaje de error si la petición falla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al registrar: $e"),
        ),
      );
    }
  } else {
    // Mostrar un mensaje de error si los campos están vacíos
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Por favor, completa todos los campos"),
      ),
    );
  }
}

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Nombre de usuario"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Contraseña"),
                obscureText: true,
              ),
              TextField(
                controller: passwordRepeatController,
                decoration: const InputDecoration(labelText: "Repetir contraseña"),
                obscureText: true,
              ),
             
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                child: const Text("Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}