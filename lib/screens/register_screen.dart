import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controladores para los campos de texto
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    // Función para manejar el registro
    void register() {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          passwordController.text == confirmPasswordController.text) {
        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cuenta creada con éxito")),
        );
        // Navegar hacia atrás
        Navigator.pop(context);
      } else {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Revisa los datos ingresados")),
        );
      }
    }

    return Scaffold(
      body: Center(
        child: Card(
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
                // Título del formulario
                const Text(
                  "Registro",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Campo de texto para el email
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                // Campo de texto para la contraseña
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: "Contraseña"),
                  obscureText: true,
                ),
                // Campo de texto para confirmar la contraseña
                TextField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: "Confirmar Contraseña",
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                // Botón para registrar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: register,
                  child: const Text("Registrar"),
                ),
                // Botón para navegar al inicio de sesión
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
    );
  }
}
