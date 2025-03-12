import 'package:flutter/material.dart';
import 'package:flutter_listatareas_api/service/api_service.dart';
import 'package:flutter_listatareas_api/widgets/common_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController = TextEditingController();

  final ApiService apiService = ApiService(
    baseUrl: 'https://api-rest-segura-2.onrender.com',
  );

  void register() async {
    if (usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordRepeatController.text.isNotEmpty &&
        passwordController.text == passwordRepeatController.text) {
      try {
        await apiService.register(
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          passwordRepeat: passwordRepeatController.text,
        );
        if (!mounted) return; // Verificar si el widget aún está montado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cuenta creada con éxito")),
        );
        Navigator.pushReplacementNamed(context, '/');
      } catch (response) {
        if (!mounted) return; // Verificar si el widget aún está montado
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error al crear la cuenta: ${response.toString()}")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Revisa los datos ingresados")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Tamaño principal mínimo
                children: [
                  const Text(
                    "Registro",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: usernameController,
                    labelText: "Nombre de usuario",
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    labelText: "Email",
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    labelText: "Contraseña",
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordRepeatController,
                    labelText: "Repetir contraseña",
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Registrar",
                    onPressed: register,
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("¿Ya tienes una cuenta? Inicia sesión"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}